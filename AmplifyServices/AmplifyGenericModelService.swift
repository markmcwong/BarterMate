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
    
    func get(byId id: String) async throws -> T.CodableType? {
        let item = try await Amplify.DataStore.query(T.self, byId: id)
        return try item?.toJSON() as? T.CodableType
    }
    
    func query(_ query: ModelQuery<T.CodableType>) async throws -> [T] {
//        var wherePredicate: QueryPredicate?
//        if let whereClause = query.whereClause {
//            let jsonData = try JSONEncoder().encode(whereClause)
//            let jsonString = String(data: jsonData, encoding: .utf8)!
//            wherePredicate = QueryPredicate(json: jsonString)
//        }
//
//        var sortInput: QuerySortInput?
//        if let sortBy = query.sortBy {
//            sortInput = QuerySortInput(fieldName: sortBy, sortOrder: .ascending)
//        }
//
//        var paginationInput: QueryPaginationInput?
//        if let limit = query.limit {
//            paginationInput = QueryPaginationInput(limit: limit)
//        }
//
//        let items = try await Amplify.DataStore.query(T.self, where: wherePredicate, sort: sortInput, paginate: paginationInput)
//        return items
    }
}

class Test {
    var service = AmplifyGenericModelService<Item>()
}
