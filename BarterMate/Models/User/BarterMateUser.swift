//
//  BarterMateUser.swift
//  BarterMate
//
//  Created by Zico on 24/3/23.
//

import Foundation

class BarterMateUser: ObservableObject, Hashable, ListElement {
    private(set) var id: Identifier<BarterMateUser>
    @Published private(set) var username: String

    static func == (lhs: BarterMateUser, rhs: BarterMateUser) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(username)
    }

    private var userFacade: (any UserFacade)?

    static func getUserWithId(id: Identifier<BarterMateUser>) -> BarterMateUser {
        let user = createEmptyUser(id: id)
        let facade = AmplifyUserFacade()
        user.userFacade = facade
        facade.delegate = user
        user.userFacade?.getUserById(id: id)
        return user
    }

    static func createEmptyUser(id: Identifier<BarterMateUser>) -> BarterMateUser {
        BarterMateUser(id: id, username: "")
    }

    init(id: Identifier<BarterMateUser> = Identifier(value: UUID().uuidString), username: String) {
        self.id = id
        self.username = username
    }

}

extension BarterMateUser: UserFacadeDelegate {
    func update(user: BarterMateUser) {
        self.id = user.id
        self.username = user.username
    }
}
