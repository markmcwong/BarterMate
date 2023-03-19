//
//  AuthService.swift
//  BarterMate
//
//  Created by Mark on 17/3/23.
//

import Foundation
import Amplify
import Combine

protocol AuthService {
    func signUp(username: String, email: String, phoneNumber: String, password: String) async -> ActionResult
    func signInWithEmail(email: String, password: String) async -> ActionResult
    func signInWithPhoneNumber(phoneNumber: String, password: String) async -> ActionResult
    func signOut() async throws
    func getCurrentUser() async throws -> AuthUser?
    func confirmSignUp(username: String, confirmationCode: String) async -> ActionResult
}
