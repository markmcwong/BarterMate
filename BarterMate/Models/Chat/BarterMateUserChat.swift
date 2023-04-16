//
//  BarterMateUserChat.swift
//  BarterMate
//
//  Created by mark on 10/4/2023.
//

import Foundation

class BarterMateUserChat: Hashable, Identifiable, ListElement {
    private(set) var id: Identifier<BarterMateUserChat>
    private(set) var chat: BarterMateChat
    private(set) var user: BarterMateUser

    static func == (lhs: BarterMateUserChat, rhs: BarterMateUserChat) -> Bool {
        lhs.id == rhs.id && lhs.chat.id == rhs.chat.id && lhs.user.id == rhs.user.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(chat.id)
        hasher.combine(user.id)
    }

    init(id: Identifier<BarterMateUserChat> = Identifier(value: UUID().uuidString),
         chat: BarterMateChat,
         user: BarterMateUser) {
        self.id = id
        self.chat = chat
        self.user = user
    }
}
