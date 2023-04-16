//
//  MultiSelectableItemViewModel.swift
//  BarterMate
//
//  Created by Zico on 12/4/23.
//

import Foundation
import Combine

class MultiSelectableItemViewModel<U: ListElement>: ObservableObject {
    @Published private(set) var itemList: ModelList<U>
    @Published var selectedItem: Set<U> = []
    private var cancellables: Set<AnyCancellable> = []

    init(itemList: ModelList<U>) {
        self.itemList = itemList
        itemList.objectWillChange.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }

    func selectItem(item: U) {
        selectedItem.insert(item)
    }

    func unSelectItem(item: U) {
        selectedItem.remove(item)
    }
}
