//
//  DataStoreService.swift
//  BarterMate
//
//  Created by Zico on 14/3/23.
//

import Amplify
import Combine

protocol DataStoreService {

    var user: User? { get }
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> { get }
    
    func configure(_ sessionState: Published<SessionState>.Publisher)
    
    func saveUser(_ user: User) async throws -> User
    
    func saveItem(_ item: Item) async throws -> Item
    func deleteItem(_ item: Item) async throws
    
    func savePosting(_ posting: Posting) async throws -> Posting
    func deletePosting(_ posting: Posting) async throws
    
    func saveRequest(_ request: Request) async throws -> Request
    func deleteRequest(_ request: Request) async throws
    
    func query<M: Model>(_ model: M.Type,
                         where predicate: QueryPredicate?,
                         sort sortInput: QuerySortInput?,
                         paginate paginationInput: QueryPaginationInput?) async throws -> [M]
    
    func query<M: Model>(_ model: M.Type, byId: String) async throws -> M?
}
