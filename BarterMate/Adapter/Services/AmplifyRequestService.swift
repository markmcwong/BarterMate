//
//  AmplifyRequestService.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

import Foundation
import Amplify

class AmplifyRequestService : RequestService {
    
    var eventsPublisher = AmplifyEventsPublisher.shared
    
    func saveRequest(_ request: Request) async throws -> Request {
        let savedRequest = try await Amplify.DataStore.save(request)
        eventsPublisher.dataStoreServiceEventsTopic.send(.requestCreated(request))
        return savedRequest
    }
    
    func deleteRequest(_ request: Request) async throws {
        try await Amplify.DataStore.delete(request)
        eventsPublisher.dataStoreServiceEventsTopic.send(.requestDeleted(request))
    }
    
    func query(where predicate: QueryPredicate?,
               sort sortInput: QuerySortInput?,
               paginate paginationInput: QueryPaginationInput?) async throws -> [Request] {
        return try await Amplify.DataStore.query(Request.self,
                                                 where: predicate,
                                                 sort: sortInput,
                                                 paginate: paginationInput)
    }
    
    func query(byId: String) async throws -> Request? {
        return try await Amplify.DataStore.query(Request.self, byId: byId)
    }
}
