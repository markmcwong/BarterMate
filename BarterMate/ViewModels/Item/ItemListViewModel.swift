////
////  PostingListViewModel.swift
////  BarterMate
////
////  Created by Zico on 18/3/23.
////
//

import Foundation

class ItemListViewModel: ObservableObject {
    @Published var user: BarterMateUser
    @Published var itemList: ModelList<BarterMateItem>
    
    init(user: BarterMateUser, itemList: ModelList<BarterMateItem>) {
        self.user = user
        self.itemList = itemList
    }
    
    func deleteItem(item: BarterMateItem) {
        itemList.delete(element: item)
        itemList.remove(model: item)
    }
}
