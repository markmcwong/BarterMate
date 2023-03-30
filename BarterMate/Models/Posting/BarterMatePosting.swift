//
//  BarterMatePosting.swift
//  BarterMate
//
//  Created by Zico on 25/3/23.
//

import Foundation

class BarterMatePosting: Hashable, ListElement {
    let id: Identifier<BarterMatePosting>
    let item: BarterMateItem
    var createdAt: Date
    var updatedAt: Date
    
    init(id: Identifier<BarterMatePosting>, item: BarterMateItem, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.item = item
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func == (lhs: BarterMatePosting, rhs: BarterMatePosting) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
