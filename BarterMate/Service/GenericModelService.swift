//
//  GenericModelService.swift
//  BarterMate
//
//  Created by mark on 21/3/2023.
//

import Foundation
import Amplify

protocol BarterMateModel: Codable, Model {
    associatedtype CodableType: Codable
    var id: String { get }
}

struct ModelQuery<T: Codable>: Codable {
    var whereClause: T?
    var sortBy: String?
    var limit: Int?
    var nextToken: String?
}

protocol GenericModelService {
    associatedtype ModelType: BarterMateModel
    
    func save(_ model: ModelType) async throws -> ModelType
    func delete(_ model: ModelType) async throws
    func get(byId id: String) async throws -> ModelType.CodableType?
    func query(_ query: ModelQuery<ModelType.CodableType>) async throws -> [ModelType]
}
