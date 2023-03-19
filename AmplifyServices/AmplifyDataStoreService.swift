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

    private var subscribers = Set<AnyCancellable>()
    
    init() {
        self.start()
    }

    func save(_ model: Model) async throws -> Model {
        let savedItem = try await Amplify.DataStore.save(model)
        return savedItem
    }
    
    func delete(_ model: Model) async throws {
        try await Amplify.DataStore.delete(model)
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
