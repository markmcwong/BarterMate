//
//  GenericModelService.swift
//  BarterMate
//
//  Created by mark on 21/3/2023.
//

import Foundation
import Amplify

protocol BarterMateModel: Codable, Model {
    associatedtype key
//    associatedtype CodableType: Codable
    var id: String { get }
    static func getModelKey(input: String) -> key?
}

protocol ModelQuery<T>: Codable {
    associatedtype T: BarterMateModel
    var whereClause: T? { get set }
    var sortBy: String? { get set }
    var limit: Int? { get set }
    var nextToken: String? { get set }
    var isAscending: Bool? { get set }
    var page: Int? {get set}
}

class Query<T: BarterMateModel>: ModelQuery {
    var whereClause: T?
    var sortBy: String?
    var limit: Int?
    var nextToken: String?
    var isAscending: Bool?
    var page: Int?
    
    init(whereClause: T? = nil,
             sortBy: String? = nil,
             limit: Int? = nil,
             isAscending: Bool? = true,
             page: Int? = 0) {
            
            self.whereClause = whereClause
            self.sortBy = sortBy
            self.limit = limit
            self.isAscending = isAscending
            self.page = page
        }
}

protocol GenericModelService<ModelType> {
    associatedtype ModelType: BarterMateModel
    
    func save(_ model: ModelType) async throws -> ModelType
    func delete(_ model: ModelType) async throws
    func get(byId id: String) async throws -> ModelType?
    func query(_ query: any ModelQuery<ModelType>) async throws -> [ModelType]
}
