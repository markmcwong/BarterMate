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
    var fetchMessagesClosure: (() async -> ())? // (() -> Task<(), Never>)?

    init(id: Identifier<any ListElement> = Identifier(value: UUID().uuidString),
         name: String?,
         messages: [BarterMateMessage] = [],
         users: [BarterMateUser] = [],
         fetchMessagesClosure: @escaping (() async -> ())) {
//         fetchMessagesClosure: (() -> Task<(), Never>)? = nil) {
        self.id = id
        self.name = name
        self.messages = messages
        self.users = users
        self.fetchMessagesClosure = fetchMessagesClosure
    }
    
    
    func fetchMessages(completion: @escaping () -> Void) async {
        if let fetchMessagesClosure = fetchMessagesClosure {
            await fetchMessagesClosure()
//                completion()
        } else {
//            completion()
        }
    }
//    func setFetchMessages(_ fetchMessages: @escaping () async -> Void) {
//        self.fetchMessages = fetchMessages
//    }
    
    static func == (lhs: BarterMateChat, rhs: BarterMateChat) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
