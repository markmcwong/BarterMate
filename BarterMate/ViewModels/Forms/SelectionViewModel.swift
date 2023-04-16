//
//  SelectionViewModel.swift
//  BarterMate
//
//  Created by Zico on 9/4/23.
//

import Foundation

protocol SelectionViewModel: ObservableObject {
    var itemList: ModelList<BarterMateItem> { get }
    var highlightedItem: BarterMateItem? { get set }
    var filteredItems: [BarterMateItem] { get }
}

extension SelectionViewModel {
    func highlightItem(item: BarterMateItem) {
        highlightedItem = item
    }
}
