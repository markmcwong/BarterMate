//
//  AmplifyUserFacade.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import Foundation
import Amplify

class AmplifyUserFacade: UserFacade {
    var delegate: (any UserFacadeDelegate)?
    
    func getUserById(id: Identifier<BarterMateUser>) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            print(id.value)
            guard let amplifyUser = try await Amplify.DataStore.query(User.self, byId: id.value) else {
                print("no user")
                return
            }

            guard let barterMateUser = AmplifyUserConverter.toBarterMateModel(user: amplifyUser) else {
                return
            }

            delegate.update(user: barterMateUser)
            
        }
    }
}
