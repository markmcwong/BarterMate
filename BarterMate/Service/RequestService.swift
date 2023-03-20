//
//  RequestService.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

import Foundation
import Amplify

protocol RequestService {
    
    func saveRequest(_ request: Request) async throws -> Request
    func deleteRequest(_ request: Request) async throws
    
    func query(where predicate: QueryPredicate?,
               sort sortInput: QuerySortInput?,
               paginate paginationInput: QueryPaginationInput?) async throws -> [Request]
    
    func query(byId: String) async throws -> Request?
}
