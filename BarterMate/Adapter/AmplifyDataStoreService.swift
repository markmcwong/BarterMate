//
//  AmplifyDataStoreService.swift
//  BarterMate
//
//  Created by Zico on 15/3/23.
//

import Foundation
import Combine
import AWSDataStorePlugin
import Amplify

class AmplifyDataStoreService: DataStoreService {
    
    private var authUser: AuthUser?
    private var dataStoreServiceEventsTopic: PassthroughSubject<DataStoreServiceEvent, DataStoreError>
    
    var user: User?
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> {
        return dataStoreServiceEventsTopic.eraseToAnyPublisher()
    }
    private var subscribers = Set<AnyCancellable>()
    
    init() {
        self.dataStoreServiceEventsTopic = PassthroughSubject<DataStoreServiceEvent, DataStoreError>()
    }
    
    func configure(_ sessionState: Published<SessionState>.Publisher) {
    
    }
    
    func saveUser(_ user: User) async throws -> User {
        let savedUser = try await Amplify.DataStore.save(user)
        dataStoreServiceEventsTopic.send(.userUpdated(savedUser))
        return savedUser
    }
    
    
    func saveItem(_ item: Item) async throws -> Item {
        let savedItem = try await Amplify.DataStore.save(item)
        dataStoreServiceEventsTopic.send(.itemCreated(savedItem))
        return savedItem
    }
    
    func deleteItem(_ item: Item) async throws {
        try await Amplify.DataStore.delete(item)
        dataStoreServiceEventsTopic.send(.itemDeleted(item))
    }
    
    func savePosting(_ posting: Posting) async throws -> Posting {
        let savedPosting = try await Amplify.DataStore.save(posting)
        dataStoreServiceEventsTopic.send(.postingCreated(savedPosting))
        return savedPosting
    }
    
    func deletePosting(_ posting: Posting) async throws {
        try await Amplify.DataStore.delete(posting)
        dataStoreServiceEventsTopic.send(.postingDeleted(posting))
    }
    
    func saveRequest(_ request: Request) async throws -> Request {
        let savedRequest = try await Amplify.DataStore.save(request)
        dataStoreServiceEventsTopic.send(.requestCreated(savedRequest))
        return savedRequest
    }
    
    func deleteRequest(_ request: Request) async throws {
        try await Amplify.DataStore.delete(request)
        dataStoreServiceEventsTopic.send(.requestDeleted(request))
    }
    
    func createChat(chatName: String, users: [User]) async throws -> Chat {
        let chat = Chat(name: chatName)
        let savedChat = try await Amplify.DataStore.save(chat)
        
        for user in users {
            let userChat = UserChat(chat: savedChat, user: user)
            try await Amplify.DataStore.save(userChat)
        }
        
        return savedChat
    }
    
    func fetchChat(id: String) async throws -> Chat? {
        return try await Amplify.DataStore.query(Chat.self, byId: id)
    }
    
    func fetchMessagesByChat(chatID: String) async throws -> [Message] {
        let messages = try await Amplify.DataStore.query(Message.self, where: Message.keys.SentTo == chatID)
        return messages
    }
    
    func fetchChatsByUser(userID: String) async throws -> [Chat] {
        let userChats = try await Amplify.DataStore.query(UserChat.self, where: UserChat.keys.user == userID)
        
        return try await withThrowingTaskGroup(of: Chat?.self) { group in
            for userChat in userChats {
                group.addTask {
                    return try await Amplify.DataStore.query(Chat.self, byId: userChat.chat.id)
                }
            }
            
            var chats: [Chat] = []
            for try await chat in group {
                if let chat = chat {
                    chats.append(chat)
                }
            }
            
            return chats
        }
    }

    
    func createMessage(chat: Chat, sentBy: User, content: String) async throws -> Message {
        let createdAt = Temporal.DateTime.now()
        let message = Message(SentTo: chat, SentBy: sentBy, createdAt: createdAt, content: content, messageSentById: sentBy.id)
        try await Amplify.DataStore.save(message)
        return message
    }
    
    func query<M: Model>(_ model: M.Type,
                  where predicate: QueryPredicate?,
                  sort sortInput: QuerySortInput?,
                  paginate paginationInput: QueryPaginationInput?) async throws -> [M] {
        return try await Amplify.DataStore.query(model,
                                                 where: predicate,
                                                 sort: sortInput,
                                                 paginate: paginationInput)
    }
    
    func query<M: Model>(_ model: M.Type,
                  byId: String) async throws -> M? where M : Model {
        return try await Amplify.DataStore.query(model, byId: byId)
    }
    
    private func start() {
        Task {
            try await Amplify.DataStore.start()
        }
    }
    private func clear() {
        Task {
            try await Amplify.DataStore.clear()
        }
    }

}

extension AmplifyDataStoreService {
    
    private func createUser() async {
        guard let authUser = self.authUser else {
            return
        }
        
        let user = User(id: "\(authUser.userId)",
                        username: authUser.username)
        
        do {
            _ = try await saveUser(user)
            self.user = user
            dataStoreServiceEventsTopic.send(.userSynced(user))
            Amplify.log.debug("Created user \(authUser.username)")
        } catch let dataStoreError as DataStoreError {
            self.dataStoreServiceEventsTopic.send(completion: .failure(dataStoreError))
            Amplify.log.error("Error creating user \(authUser.username) - \(dataStoreError.localizedDescription)")
        } catch {
            Amplify.log.error("Error creating user \(authUser.username) - \(error.localizedDescription)")
        }
    }
    
    private func getUser() async {
        guard let userId = authUser?.userId else {
            return
        }
        
        do {
            let user = try await query(User.self, byId: userId)
            guard let user = user else {
                await createUser()
                return
            }
            self.user = user
            dataStoreServiceEventsTopic.send(.userSynced(user))
        } catch {
            Amplify.log.error("Error querying User - \(error.localizedDescription)")
        }
    }
    
    private func subscribe(to sessionState: Published<SessionState>.Publisher?) {
        sessionState?
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .signedOut:
                    self.clear()
                    self.user = nil
                    self.authUser = nil
                case .signedIn(let authUser):
                    self.authUser = authUser
                    self.start()
                case .initializing:
                    break
                }
            }
            .store(in: &subscribers)
    }
    
    private func subscribeToDataStoreHubEvents() {
        Amplify.Hub.publisher(for: .dataStore)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {payload in
                self.hubEventsHandler(payload: payload)
            })
            .store(in: &subscribers)
    }
    
    private func handleModelSyncedEvent(modelSyncedEvent: ModelSyncedEvent) {
        switch modelSyncedEvent.modelName {
        case User.modelName:
            Task {
                await getUser()
            }
        case Posting.modelName:
            dataStoreServiceEventsTopic.send(.postingSynced)
        case Request.modelName:
            dataStoreServiceEventsTopic.send(.requestSynced)
        default:
            return
        }
    }
    
    private func hubEventsHandler(payload: HubPayload) {

        switch payload.eventName {
        case HubPayload.EventName.DataStore.modelSynced:
            guard let modelSyncedEvent = payload.data as? ModelSyncedEvent else {
                Amplify.log.error(
                    """
                    Failed to case payload of type '\(type(of: payload.data))' \
                    to ModelSyncedEvent.
                    """
                )
                return
            }

            handleModelSyncedEvent(modelSyncedEvent: modelSyncedEvent);
        default:
            return
        }
    }
}
