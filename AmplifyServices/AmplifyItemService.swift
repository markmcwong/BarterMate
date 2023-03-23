    //
//  AmplifyItemService.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

import Amplify

class AmplifyItemService: ItemService {
 
    var eventsPublisher = AmplifyEventsPublisher.shared
    
    func saveItem(_ item: Item) async throws -> Item {
        let savedItem = try await Amplify.DataStore.save(item)
        eventsPublisher.dataStoreServiceEventsTopic.send(.itemCreated(savedItem))
        return savedItem
    }
    
    func deleteItem(_ item: Item) async throws {
        try await Amplify.DataStore.delete(item)
        eventsPublisher.dataStoreServiceEventsTopic.send(.itemDeleted(item))
    }
    
    func query(where predicate: QueryPredicate?,
               sort sortInput: QuerySortInput?,
               paginate paginationInput: QueryPaginationInput?) async throws -> [Item] {
        return try await Amplify.DataStore.query(Item.self,
                                                 where: predicate,
                                                 sort: sortInput,
                                                 paginate: paginationInput)
    }
    
    func query(byId: String) async throws -> Item? {
        return try await Amplify.DataStore.query(Item.self, byId: byId)
    }
}
