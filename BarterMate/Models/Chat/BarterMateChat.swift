//
//  BarterMateChat.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Foundation

class BarterMateChat: Hashable, Identifiable, ListElement {
    let id: Identifier<Chat>
    var name: String?
    var messages: [BarterMateMessage]
    var users: [BarterMateUser]
    
    init(id: Identifier<Chat> = Identifier(value: UUID().uuidString),
         name: String?,
         messages: [BarterMateMessage] = [],
         users: [BarterMateUser] = []) {
        self.id = id
        self.name = name
        self.messages = messages
        self.users = users
    }
    
    static func == (lhs: BarterMateChat, rhs: BarterMateChat) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
