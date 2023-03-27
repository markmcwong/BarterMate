//
//  BarterMatePosting.swift
//  BarterMate
//
//  Created by Zico on 25/3/23.
//

import Foundation

class BarterMatePosting {
    let id: Identifier<BarterMatePosting>
    let item: Item
    var createdAt: Date
    var updatedAt: Date
    
    init(id: Identifier<BarterMatePosting>, item: Item, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.item = item
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
