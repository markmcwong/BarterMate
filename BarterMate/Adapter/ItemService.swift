//
//  ItemService.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

import Amplify

protocol ItemService {
    
    var eventsPublisher: EventsPublisher { get }
    
    func saveItem(_ item: Item) async throws -> Item
    func deleteItem(_ item: Item) async throws
    
    func query(where predicate: QueryPredicate?,
               sort sortInput: QuerySortInput?,
               paginate paginationInput: QueryPaginationInput?) async throws -> [Item]
    
    func query(byId: String) async throws -> Item?
}
