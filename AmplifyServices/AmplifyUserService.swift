//
//  AmplifyUserService.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

import Amplify

class AmplifyUserService: UserService {

    var user: User?
  
    var eventsPublisher = AmplifyEventsPublisher.shared
    
    func saveUser(_ user: User) async throws -> User {
        let savedUser = try await Amplify.DataStore.save(user)
        eventsPublisher.dataStoreServiceEventsTopic.send(.userLoaded(user))
        return savedUser
    }
    

    func query(byId: String) async throws -> User? {
        return try await Amplify.DataStore.query(User.self, byId: byId)
    }
}
