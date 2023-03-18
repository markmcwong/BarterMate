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

    var user: User? { get }
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> { get }
    
    func configure(_ sessionState: Published<SessionState>.Publisher)
    func configure()
    
    func saveUser(_ user: User) async throws -> User
    
    func saveItem(_ item: Item) async throws -> Item
    func deleteItem(_ item: Item) async throws
    
    func savePosting(_ posting: Posting) async throws -> Posting
    func deletePosting(_ posting: Posting) async throws
    
    func saveRequest(_ request: Request) async throws -> Request
    func deleteRequest(_ request: Request) async throws
    
    // Chat Related functions
    func createChat(chatName: String, users: [User]) async throws -> Chat
    func fetchChat(id: String) async throws -> Chat?
    func fetchMessagesByChat(chatID: String) async throws -> [Message]
    func fetchChatsByUser(userID: String) async throws -> [Chat]
    func createMessage(chat: Chat, sentBy: User, content: String) async throws -> Message
    
    func query<M: Model>(_ model: M.Type,
                         where predicate: QueryPredicate?,
                         sort sortInput: QuerySortInput?,
                         paginate paginationInput: QueryPaginationInput?) async throws -> [M]
    
    func query<M: Model>(_ model: M.Type, byId: String) async throws -> M?
    
    func dataStorePublisher<M: Model>(for model: M.Type)
    -> AnyPublisher<AmplifyAsyncThrowingSequence<MutationEvent>.Element, Error>
}
