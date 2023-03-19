//
//  AmplifyPostingService.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

import Amplify
import Foundation

class AmplifyPostingService: PostingService {
    
    var eventsPublisher = AmplifyEventsPublisher.shared
    
    func savePosting(_ posting: Posting) async throws -> Posting {
        let savedItem = try await Amplify.DataStore.save(posting)
        eventsPublisher.dataStoreServiceEventsTopic.send(.postingCreated(posting))
        return savedItem
    }
    
    func deletePosting(_ posting: Posting) async throws {
        try await Amplify.DataStore.delete(posting)
        eventsPublisher.dataStoreServiceEventsTopic.send(.postingDeleted(posting))
    }
    
    func query(where predicate: QueryPredicate?,
               sort sortInput: QuerySortInput?,
               paginate paginationInput: QueryPaginationInput?) async throws -> [Posting] {
        return try await Amplify.DataStore.query(Posting.self,
                                                 where: predicate,
                                                 sort: sortInput,
                                                 paginate: paginationInput)
    }
    
    func query(byId: String) async throws -> Posting? {
        return try await Amplify.DataStore.query(Posting.self, byId: byId)
    }
}
