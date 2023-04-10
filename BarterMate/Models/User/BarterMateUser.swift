//
//  BarterMateUser.swift
//  BarterMate
//
//  Created by Zico on 24/3/23.
//

import Foundation

class BarterMateUser: ObservableObject {
    var id: Identifier<BarterMateUser>
    @Published var username: String
    @Published var profilePicUrl: String?
    
    private var userFacade: (any UserFacade)?
    
    static func getUserWithId(id: Identifier<BarterMateUser>) -> BarterMateUser {
        let user = createEmptyUser()
        let facade = AmplifyUserFacade()
        user.userFacade = facade
        facade.delegate = user
        user.userFacade?.getUserById(id: id)
        return user
    }
    
    static func createEmptyUser() -> BarterMateUser {
        BarterMateUser(id: Identifier(value: ""), username: "")
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
