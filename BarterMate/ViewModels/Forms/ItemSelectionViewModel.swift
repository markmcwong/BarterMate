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
    @Published var highlightedItem: BarterMateItem?
    private var cancellables: Set<AnyCancellable> = []
    
    init(userid: Identifier<BarterMateUser>, postingList: ModelList<BarterMatePosting>) {
        self.postingList = postingList
        itemList = ModelList<BarterMateItem>.of(userid)
        itemList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
    
    var filteredItemLists : [BarterMateItem] {
        itemList.elements.filter { item in
            for posting in postingList.elements {
                if posting.item == item {
                    return false
                }
            }
            return true
        }
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
