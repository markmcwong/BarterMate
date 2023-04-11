//
//  OfferSelectionViewModel.swift
//  BarterMate
//
//  Created by Zico on 9/4/23.
//

import Foundation
import Combine

class OfferSelectionViewModel: ObservableObject {
    var transaction: BarterMateTransaction
    @Published var itemList: ModelList<BarterMateItem>
    @Published var highlightedItem: BarterMateItem?
    private var cancellables: Set<AnyCancellable> = []
    
    init(userId: Identifier<BarterMateUser>, transaction: BarterMateTransaction) {
        print("Offer")
        self.transaction = transaction
        self.itemList = ItemList.of(userId)
        itemList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
            print(self?.itemList.elements.count)
        }.store(in: &cancellables)
    }
    
    var filteredItems: [BarterMateItem] {
        itemList.elements.filter { !transaction.itemPool.contains($0) }
    }
    
    func offerItem() {
        guard let highlightedItem = highlightedItem else {
            return
        }
        
        transaction.addItem(item: highlightedItem)
    }
}

