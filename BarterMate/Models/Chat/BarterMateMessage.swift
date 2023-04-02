//
//  BarterMateMessage.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Foundation

class BarterMateMessage: Hashable, Identifiable, ListElement {
    let id: Identifier<BarterMateMessage>
    let sentIn: BarterMateChat?
    let sentBy: BarterMateUser
    let createdAt: Date
    let content: String
    
    init(id: Identifier<BarterMateMessage> = Identifier(value: UUID().uuidString),
         sentIn: BarterMateChat?,
         sentBy: BarterMateUser,
         createdAt: Date,
         content: String) {
        self.id = id
        self.sentIn = sentIn
        self.sentBy = sentBy
        self.createdAt = createdAt
        self.content = content
    }
    
    static func == (lhs: BarterMateMessage, rhs: BarterMateMessage) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
