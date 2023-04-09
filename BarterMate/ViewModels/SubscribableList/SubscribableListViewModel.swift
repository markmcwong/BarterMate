//
//  SubscribableListViewModel.swift
//  BarterMate
//
//  Created by mark on 7/4/2023.
//

import Foundation
import Combine

class SubscribableListViewModel<U: ListElement>: ObservableObject {
    @Published var items: [U] = []
    private var cancellable: Cancellable?
    private let provider: AmplifySubscriptionProvider<U>

    init() {
        self.provider = AmplifySubscriptionProvider<U>()
        subscribeToUpdates()
    }

    func subscribeToUpdates() {
        print("subscribeToUpdates called")
//        cancellable = provider.querySubscription(U.self) { [weak self] result in
//            switch result {
//            case .success(let items):
//                print("subscribeToUpdates success - items: ", items)
//                DispatchQueue.main.async {
//                    self!.items = items
//                }
//            case .failure(let error):
//                print("Failed to receive updates with error: \(error)")
//            }
//        }
        cancellable = provider.querySubscription(U.self) { [weak self] result in
            DispatchQueue.main.async {
                self!.items = result
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
