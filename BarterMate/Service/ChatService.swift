//
//  ChatService.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

import Foundation
import Amplify

protocol ChatService {
    
    func createChat(chatName: String, users: [User]) async throws -> Chat
    func fetchChat(id: String) async throws -> Chat?
//    func fetchMessagesByChat(chatID: String) async throws -> [Message]
    func fetchChatsByUser(userID: String) async throws -> [Chat]
    func createMessage(chat: Chat, sentBy: User, content: String) async throws -> Message
    
    func query(where predicate: QueryPredicate?,
               sort sortInput: QuerySortInput?,
               paginate paginationInput: QueryPaginationInput?) async throws -> [Posting]
    
    func query(byId: String) async throws -> Posting?
}
