//
//  SubscriptionProvider.swift
//  BarterMate
//
//  Created by mark on 4/4/2023.
//

import Foundation
import Amplify

protocol SubscriptionProvider {
    associatedtype ModelType: ListElement
//    associatedtype PredicateType: BarterMatePredicate
    
//    func querySubscription<ModelType: Model>(_ modelType: ModelType.Type, where predicate: QueryPredicate?, sort: QuerySortInput?, completion: @escaping (Result<ModelType, DataStoreError>) -> Void) -> Cancellable
    
    func querySubscription<L: ListElement>(_ modelType: L.Type, where predicate: QueryPredicate?, sort: QuerySortInput?, completion: @escaping (Result<L, DataStoreError>) -> Void) -> Cancellable

    func cancelSubscription()
    func save(_ item: ModelType, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol Cancellable {
    func cancel()
}
