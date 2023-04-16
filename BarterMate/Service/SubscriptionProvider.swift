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

    func querySubscription<L: ListElement>(_ modelType: L.Type,
                                           where predicate: QueryPredicate?,
                                           sort: QuerySortInput?,
                                           completion: @escaping ([L]) -> Void) -> Cancellable

    func cancelSubscription()
    func save(_ item: ModelType, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol Cancellable {
    func cancelSubscription()
}
