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
    let predicate: QueryPredicate?

    init() {
        self.provider = AmplifySubscriptionProvider<U>()
        self.predicate = nil
        subscribeToUpdates()
    }

    init(where predicate: QueryPredicate) {
        self.provider = AmplifySubscriptionProvider<U>()
        self.predicate = predicate
        subscribeToUpdatesWithPredicate(where: predicate)
    }

    func subscribeToUpdates() {
        print("subscribeToUpdates called")
        cancellable = provider.querySubscription(U.self) { [weak self] result in
            DispatchQueue.main.async {
                print("subscribeToUpdates : ")
                for res in result {
                    print(res)
                }
                print("res loop finished")
                self?.items = result
            }
        }
    }

    func subscribeToUpdatesWithPredicate(where predicate: QueryPredicate?) {
        if predicate != nil {
            print("subscribeToUpdatesWithPredicate called")
            cancellable = provider.querySubscription(U.self, where: predicate) { [weak self] result in
                DispatchQueue.main.async {
                    print("subscribeToUpdatesWithPredicate:  " + result.debugDescription)
//                    for res in result{
//                        print(res)
//                    }
//                    print("res loop finished")
                    self?.items = result
                    self?.objectWillChange.send()
                }
            }
        } else {
            subscribeToUpdates()
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
