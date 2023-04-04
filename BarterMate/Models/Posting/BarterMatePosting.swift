//
//  BarterMatePosting.swift
//  BarterMate
//
//  Created by Zico on 25/3/23.
//

import Foundation

class BarterMatePosting: Hashable, ListElement, ObservableObject {
    let id: Identifier<BarterMatePosting>
    @Published var item: BarterMateItem
    var createdAt: Date
    var updatedAt: Date
    
    init(id: Identifier<BarterMatePosting> = Identifier(value: UUID().uuidString), item: BarterMateItem, createdAt: Date, updatedAt: Date) {
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
