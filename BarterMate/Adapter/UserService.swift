//
//  UserService.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

import Foundation

protocol UserService {
    
    var user: User? { get }
    
    var eventsPublisher: EventsPublisher { get }
    
    func saveUser(_ user: User) async throws -> User
    
    func query(byId: String) async throws -> User?
}
