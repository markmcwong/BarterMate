//
//  AmplifyUserAdapter.swift
//  BarterMate
//
//  Created by Zico on 27/3/23.
//

import Foundation
import Amplify

struct AmplifyUserConverter {

    static func toBarterMateModel(user: User) -> BarterMateUser? {

        guard let username = user.username else {
            return nil
        }

        let barterMateUser = BarterMateUser(id: Identifier(value: user.id),
                                            username: username)

        return barterMateUser
    }


    static func toAmplifyModel(user: BarterMateUser) -> User {
        let amplifyUser = User(id: user.id.value, username: user.username)
        return amplifyUser
    }
}
