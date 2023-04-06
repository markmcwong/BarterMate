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
    
    func querySubscription(predicate: QueryPredicate, completion: @escaping (Result<ModelType, Error>) -> Void) -> Cancellable
    func cancelSubscription()
    func save(_ item: ModelType, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol Cancellable {
    func cancel()
}
