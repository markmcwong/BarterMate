//
//  ItemSelectionViewModel.swift
//  BarterMate
//
//  Created by Zico on 6/4/23.
//

import Foundation
import Combine

class ItemSelectionViewModel: ObservableObject {
    var postingList: ModelList<BarterMatePosting>
    var itemList: ModelList<BarterMateItem>
    var highlightedItem: BarterMateItem?
    private var cancellables: Set<AnyCancellable> = []
    
    init(userid: Identifier<BarterMateUser>) {
        postingList = ModelList<BarterMatePosting>.of(userid)
        itemList = ModelList<BarterMateItem>.of(userid)
        postingList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
        itemList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
    
    func highlightItem(item: BarterMateItem) {
        highlightedItem = item
    }
    
    func makePosting() {
        guard let highlightedItem = highlightedItem else {
            return
        }
        
        let newPosting = BarterMatePosting(item: highlightedItem,
                                           createdAt: .now,
                                           updatedAt: .now)
        
        postingList.saveItem(element: newPosting)
    }
    
}
