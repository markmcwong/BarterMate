//
//  OfferSelectionViewModel.swift
//  BarterMate
//
//  Created by Zico on 9/4/23.
//

import Foundation
import Combine

class OfferSelectionViewModel: SelectableItemViewModel<BarterMateItem> {

    var transaction: BarterMateTransaction

    init(userId: Identifier<BarterMateUser>, transaction: BarterMateTransaction) {
        self.transaction = transaction
        let itemList = ModelList<BarterMateItem>.of(userId)
        super.init(itemList: itemList)
    }

    var filteredItems: [BarterMateItem] {
        itemList.elements.filter { !(transaction.itemPool.contains($0)) }
    }

    func offerItem() {
        guard let highlightedItem = highlightedItem else {
            return
        }

        transaction.addItem(item: highlightedItem)
    }
}
