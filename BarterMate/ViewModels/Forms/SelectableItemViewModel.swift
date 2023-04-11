//
//  SelectableItemViewModel.swift
//  BarterMate
//
//  Created by Zico on 12/4/23.
//

import Combine
import Foundation

class SelectableItemViewModel<U: ListElement>: ObservableObject {
    @Published var itemList: ModelList<U>
    @Published var highlightedItem: U?
    private var cancellables: Set<AnyCancellable> = []
    
    init(itemList: ModelList<U>) {
        self.itemList = itemList
        itemList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
    
    func setHighlightedItem(to item: U?) {
        highlightedItem = item
    }
}
