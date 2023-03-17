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
    func signUp(username: String, email: String, phoneNumber: String, password: String) async throws -> AuthSignUpResult
//  func confirmSignUp(username: String, confirmationCode: String) async throws -> AuthConfirmSignUpRequest
    func signInWithEmail(email: String, password: String) async throws -> AuthSignInResult
    func signInWithPhoneNumber(phoneNumber: String, password: String) async throws -> AuthSignInResult
    func signOut() async throws
    func getCurrentUser() async throws -> AuthUser?
}
