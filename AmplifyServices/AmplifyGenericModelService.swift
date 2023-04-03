//
//  AmplifyGenericModelService.swift
//  BarterMate
//
//  Created by mark on 21/3/2023.
//

import Foundation
import Amplify

class AmplifyGenericModelService<T: BarterMateModel>: GenericModelService {
    func save(_ model: T) async throws -> T {
        let savedItem = try await Amplify.DataStore.save(model)
        return savedItem
    }
    
    func delete(_ model: T) async throws {
        try await Amplify.DataStore.delete(model)
    }
    
    func get(byId id: String) async throws -> T? {
        let item = try await Amplify.DataStore.query(T.self, byId: id)
        return item
    }
    
    func query(_ query: any ModelQuery<T>) async throws -> [T] {
//        var wherePredicate: QueryPredicate?
//        // TODO:
////        if let whereClause = query.whereClause {
////            let jsonData = try JSONEncoder().encode(whereClause)
////            let jsonString = String(data: jsonData, encoding: .utf8)!
////            wherePredicate = QueryPredicateGroup.(json: jsonString)
////        }
//
//        var sortInput: QuerySortInput?
//        if let sortByKey = query.sortBy, let isAscending = query.isAscending {
//            if let codingKey = T.getModelKey(input: sortByKey) {
//                sortInput = isAscending ? .ascending(codingKey as! CodingKey) : .descending(codingKey as! CodingKey)
//            }
//        }
//
//        var paginationInput: QueryPaginationInput?
//        if let limit = query.limit, let page = query.page {
//            paginationInput = QueryPaginationInput.page(UInt(page), limit: UInt(limit))
//        }

        let items = try await Amplify.DataStore.query(T.self)
        return items
    }
    
}
