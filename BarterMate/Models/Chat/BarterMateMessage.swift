//
//  BarterMateMessage.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Foundation

class BarterMateMessage: Hashable, Identifiable, ListElement, ObservableObject, CustomStringConvertible {
    let id: Identifier<BarterMateMessage>
    let sentIn: BarterMateChat?
    @Published var sentBy: BarterMateUser?
    var fetchUserClosure: ((@escaping (BarterMateUser) -> BarterMateUser) -> Void)?
    let createdAt: Date
    let content: String
    var hasFetchedDetails = false

    var description: String {
        "BarterMateMessage[\(id): { \(sentIn.debugDescription), \(sentBy.debugDescription)}"
    }

    init(id: Identifier<BarterMateMessage> = Identifier(value: UUID().uuidString),
         sentIn: BarterMateChat?,
         sentBy: BarterMateUser?,
         fetchUserClosure: ((@escaping (BarterMateUser) -> BarterMateUser) -> Void)?,
         createdAt: Date,
         content: String) {
        self.id = id
        self.sentIn = sentIn
        self.sentBy = sentBy
        self.createdAt = createdAt
        self.fetchUserClosure = fetchUserClosure
        self.content = content
    }

    static func == (lhs: BarterMateMessage, rhs: BarterMateMessage) -> Bool {
        lhs.id == rhs.id && lhs.sentBy?.id == rhs.sentBy?.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(sentBy?.hashValue)
    }

    func fetchDetails() {
        fetchUser()
        self.hasFetchedDetails = true
    }

    func fetchUser() {
        if self.sentBy == nil {
            guard let fetchUserClosure = fetchUserClosure else {
                print("fetch user closuer wrong")
                self.sentBy = nil
                return
            }
            fetchUserClosure {
                self.sentBy = $0
                print("message sentBY: ", $0.id)
                return $0
            }
            return
        }
    }
}
