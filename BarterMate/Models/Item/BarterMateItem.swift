//
//  BarterMateItem.swift
//  BarterMate
//
//  Created by Zico on 24/3/23.
//

import Foundation

class BarterMateItem: Hashable, ListElement {
    
    let id: Identifier<BarterMateItem>
    let name: String
    let description: String
    let imageUrl: String?
    let ownerId: Identifier<BarterMateUser>
    let createdAt: Date
    let updatedAt: Date
    
    init(id: Identifier<BarterMateItem>, name: String, description: String, imageUrl: String?, ownerId: Identifier<BarterMateUser>, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.ownerId = ownerId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func == (lhs: BarterMateItem, rhs: BarterMateItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
