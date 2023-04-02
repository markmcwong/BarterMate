//
//  BarterMateMessage.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Foundation

class BarterMateMessage: Hashable, Identifiable, ListElement {
    let id: Identifier<Message>
    let chatId: Identifier<Chat>
    let sentBy: BarterMateUser
    let createdAt: Date
    let content: String
    
    init(id: Identifier<Message> = Identifier(value: UUID().uuidString),
         chatId: Identifier<Chat>,
         sentBy: BarterMateUser,
         createdAt: Date,
         content: String) {
        self.id = id
        self.chatId = chatId
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