//
//  DataStoreService.swift
//  BarterMate
//
//  Created by Zico on 14/3/23.
//

import Foundation
import Amplify
import Combine

protocol DataStoreService {
    
    func save(_ model: Model) async throws -> Model
    func delete(_ model: Model) async throws
    
    // Chat Related functions
    func createChat(chatName: String, users: [User]) async throws -> Chat
    func fetchChat(id: String) async throws -> Chat?
    func fetchMessagesByChat(chatID: String) async throws -> [Message]
    func fetchChatsByUser(userID: String) async throws -> [Chat]
    func createMessage(chat: Chat, sentBy: User, content: String) async throws -> Message
}

