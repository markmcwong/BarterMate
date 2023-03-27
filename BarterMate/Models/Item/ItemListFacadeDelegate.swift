//
//  ItemListFacadeDelegate.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

protocol ItemListFacadeDelegate: AnyObject {
    func insert(item: BarterMateItem)
    func insertAll(items: [BarterMateItem])
    func remove(item: BarterMateItem)
}
