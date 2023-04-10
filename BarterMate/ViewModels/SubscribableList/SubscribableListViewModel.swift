//
//  SubscribableListViewModel.swift
//  BarterMate
//
//  Created by mark on 7/4/2023.
//

import Foundation
import Combine
import Amplify

class SubscribableListViewModel<U: ListElement>: ObservableObject {
    @Published var items: [U] = []
    private var cancellable: Cancellable?
    private let provider: AmplifySubscriptionProvider<U>

    init() {
        self.provider = AmplifySubscriptionProvider<U>()
        subscribeToUpdates()
    }
    
    init(where predicate: QueryPredicate) {
        self.provider = AmplifySubscriptionProvider<U>()
        subscribeToUpdatesWithPredicate(where: predicate)
    }

    func subscribeToUpdates() {
        print("subscribeToUpdates called")
        cancellable = provider.querySubscription(U.self) { [weak self] result in
            DispatchQueue.main.async {
                self?.items = result
            }
        }
    }
    
    func subscribeToUpdatesWithPredicate(where predicate: QueryPredicate) {
        print("subscribeToUpdates called")
        cancellable = provider.querySubscription(U.self, where: predicate) { [weak self] result in
            DispatchQueue.main.async {
                self?.items = result
            }
        }
    }

    func unsubscribeFromUpdates() {
        provider.cancelSubscription()
        cancellable?.cancelSubscription()
        cancellable = nil
    }

    func addItem(_ item: U) {
        provider.save(item) { result in
            switch result {
            case .success:
                print("Item saved successfully")
            case .failure(let error):
                print("Failed to save item with error: \(error)")
            }
        }
    }
}
