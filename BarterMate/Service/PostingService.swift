//
//  PostingService.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

import Amplify

protocol PostingService {
    
    var eventsPublisher: EventsPublisher { get }
    
    func savePosting(_ posting: Posting) async throws -> Posting
    func deletePosting(_ posting: Posting) async throws
    
    func query(where predicate: QueryPredicate?,
               sort sortInput: QuerySortInput?,
               paginate paginationInput: QueryPaginationInput?) async throws -> [Posting]
    
    func query(byId: String) async throws -> Posting?
}
