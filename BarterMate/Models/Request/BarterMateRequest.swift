//
//  BarterMateRequest.swift
//  BarterMate
//
//  Created by Zico on 25/3/23.
//

import Foundation

class BarterMateRequest: Hashable, ListElement {
    let id: Identifier<BarterMateRequest>
    private(set) var description: String
    let ownerId: Identifier<BarterMateUser>
    private(set) var createdAt: Date
    private(set) var updatedAt: Date

    init(id: Identifier<BarterMateRequest> = Identifier(value: UUID().uuidString),
         description: String, ownerId: Identifier<BarterMateUser>,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.description = description
        self.ownerId = ownerId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    static func == (lhs: BarterMateRequest, rhs: BarterMateRequest) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
