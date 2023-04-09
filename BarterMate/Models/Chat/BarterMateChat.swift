//
//  BarterMateChat.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Foundation

class BarterMateChat: Hashable, Identifiable, ListElement {
    let id: Identifier<any ListElement>
    var name: String?
    var messages: [BarterMateMessage]
    var users: [BarterMateUser]
    var fetchMessagesClosure: (@escaping ([BarterMateMessage]) -> Void) -> Void // (() -> Task<(), Never>)?
    var fetchUsersClosure: (() async -> [BarterMateUser])? // (() -> Task<(), Never>)

    init(id: Identifier<any ListElement> = Identifier(value: UUID().uuidString),
         name: String?,
         messages: [BarterMateMessage] = [],
         users: [BarterMateUser] = [],
         fetchMessagesClosure: @escaping (@escaping ([BarterMateMessage]) -> Void) -> Void,
//         fetchMessagesClosure: @escaping (() async -> [BarterMateMessage]),
         fetchUsersClosure: @escaping (() async -> [BarterMateUser])) {
//         fetchMessagesClosure: (() -> Task<(), Never>)? = nil) {
        self.id = id
        self.name = name
        self.messages = messages
        self.users = users
        self.fetchMessagesClosure = fetchMessagesClosure
        self.fetchUsersClosure = fetchUsersClosure
    }
    
    func fetchMessages() async {
        fetchMessagesClosure {
            self.messages = $0
        }
    }

    func fetchUser(completion: @escaping () -> Void) async {
        if let fetchUsersClosure = fetchUsersClosure {
            users = await fetchUsersClosure()
        } else {
            print("fetchMessage closure error")
        }
    }
    
    static func == (lhs: BarterMateChat, rhs: BarterMateChat) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
