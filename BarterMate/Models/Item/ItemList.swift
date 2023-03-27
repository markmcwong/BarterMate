//
//  ItemList.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import Foundation

class ItemList {
    var items: [BarterMateItem] = []
    
    private var itemListFacade: ItemListFacade?
    
    static func of(_ ownerId: Identifier<User>) -> ItemList {
        let itemList = ItemList()
        itemList.itemListFacade = AmplifyItemListFacade()
        itemList.itemListFacade?.delegate = itemList
        itemList.itemListFacade?.getItemsById(of: ownerId)
        return itemList
    }
}

extension ItemList: ItemListFacadeDelegate {
    func insert(item: BarterMateItem) {
        if items.contains(item) {
            items.append(item)
        }
    }
    
    func insertAll(items: [BarterMateItem]) {
        let filteredItems = items.filter { !items.contains($0) }
        self.items.append(contentsOf: filteredItems)
    }
    
    func remove(item: BarterMateItem) {
        if let index = items.firstIndex(of: item) {
            self.items.remove(at: index)
        }
    }

}
