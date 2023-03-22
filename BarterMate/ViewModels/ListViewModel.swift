//
//  ListViewModel.swift
//  BarterMate
//
//  Created by mark on 21/3/2023.
//

import Foundation
import Combine


@MainActor
class ListViewModel<T: BarterMateModel>: ObservableObject {
    @Published private(set) var loadedObjects: [T] = []
    
    private var subscribers = Set<AnyCancellable>()
    var service: any GenericModelService<T>
    
    init<U>(service: U) where U: GenericModelService, U.ModelType == T {
        self.service = service
    }
    
    func delete(_ object: T) async throws {
        try await service.delete(object)
        loadedObjects.removeAll { $0.id == object.id }
    }
    
    func fetchObjects(queryObj: any ModelQuery<T.CodableType>) async throws -> [T]? {
        loadedObjects = try await service.query(queryObj)
        return loadedObjects
    }
}

//Alternative implementation

//@MainActor
//class GenericListViewModel<T: BarterMateModel, S: GenericModelService>: ObservableObject where S.ModelType == T {
//    @Published private(set) var loadedObjects: [T] = []
//
//    private var subscribers = Set<AnyCancellable>()
//    var service: S
//
//    init(service: S) {
//        self.service = service
//    }
//
//    func delete(_ object: T) async throws {
//        try await service.delete(object)
//        loadedObjects.removeAll { $0.id == object.id }
//    }
//
//    func fetchObjects(query: ModelQuery<T.CodableType>) async throws {
//        loadedObjects = try await service.query(query)
//    }
//}
