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
        cancellable = provider.querySubscription(U.self) { [weak self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self?.items = [items]
                }
            case .failure(let error):
                print("Failed to receive updates with error: \(error)")
            }
        }
    }

    func unsubscribeFromUpdates() {
        provider.cancelSubscription()
        cancellable?.cancel()
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
