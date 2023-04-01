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
            print("id is: " + "\(id)")
            
            guard let amplifyUser = try await Amplify.DataStore.query(User.self, byId: id.value) else {
                return
            }

            guard let barterMateUser = AmplifyUserAdapter.toBarterMateModel(user: amplifyUser) else {
                return
            }
            
            print(barterMateUser.username)

            delegate.update(user: barterMateUser)
            
        }
    }
}
