//
//  ListFacadeDelegate.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import Foundation

protocol ListFacadeDelegate: AnyObject {
    func insert(item: BarterMateItem)
    func insertAll(items: [BarterMateItem])
    func remove(item: BarterMateItem)
}
