//
//  AmplifyChatService.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

//import Amplify
//import Foundation

//class AmplifyChatService: ChatService {
//    
//    var eventsPublisher = AmplifyEventsPublisher.shared
//    
//    func createChat(chatName: String, users: [User]) async throws -> Chat {
//        let chat = Chat()
//        let savedItem = try await Amplify.DataStore.save(chat)
//        eventsPublisher.dataStoreServiceEventsTopic.send(.chatCreated(chat))
//        return savedItem
//    }
//    
//    func savePosting(_ posting: Posting) async throws -> Posting {
//        let savedItem = try await Amplify.DataStore.save(posting)
//        eventsPublisher.dataStoreServiceEventsTopic.send(.postingCreated(posting))
//        return savedItem
//    }
//    
//    func deletePosting(_ posting: Posting) async throws {
//        try await Amplify.DataStore.delete(posting)
//        eventsPublisher.dataStoreServiceEventsTopic.send(.postingDeleted(posting))
//    }
//    
//    func fetchChat(id: String) async throws -> Chat? {
//        return try await Amplify.DataStore.query(Chat.self, byId: id)
//    }
//    
////    func fetchMessagesByChat(chatID: String) async throws -> [Message] {
////        let messages = try await Amplify.DataStore.query(Message.self, where: Message.keys.SentTo == chatID)
////        return messages
////    }
//    
//    func fetchChatsByUser(userID: String) async throws -> [Chat] {
//        let userChats = try await Amplify.DataStore.query(UserChat.self, where: UserChat.keys.user == userID)
//        
//        return try await withThrowingTaskGroup(of: Chat?.self) { group in
//            for userChat in userChats {
//                group.addTask {
//                    return try await Amplify.DataStore.query(Chat.self, byId: userChat.chat.id)
//                }
//            }
//            
//            var chats: [Chat] = []
//            for try await chat in group {
//                if let chat = chat {
//                    chats.append(chat)
//                }
//            }
//            
//            return chats
//        }
//    }
//
////    func createMessage(chat: Chat, sentBy: User, content: String) async throws -> Message {
////        let createdAt = Temporal.DateTime.now()
////        let message = Message(chatID: chat.id, SentBy: sentBy, createdAt: createdAt, content: content, messageSentById: sentBy.id)
////        try await Amplify.DataStore.save(message)
////        return message
////    }
//    
//    func query(where predicate: QueryPredicate?,
//               sort sortInput: QuerySortInput?,
//               paginate paginationInput: QueryPaginationInput?) async throws -> [Posting] {
//        return try await Amplify.DataStore.query(Posting.self,
//                                                 where: predicate,
//                                                 sort: sortInput,
//                                                 paginate: paginationInput)
//    }
//    
//    func query(byId: String) async throws -> Posting? {
//        return try await Amplify.DataStore.query(Posting.self, byId: byId)
//    }
//}
