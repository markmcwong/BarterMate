//
//  AmplifyAuthService.swift
//  BarterMate
//
//  Created by Mark on 17/3/23.
//

import Foundation
import Amplify

public class AmplifyAuthService: AuthService {
    
    func signUp(username: String, email: String, phoneNumber: String, password: String) async throws -> AuthSignUpResult {
            let attributes = [
                AuthUserAttribute(.email, value: email),
                AuthUserAttribute(.phoneNumber, value: phoneNumber)
            ]
            let options = AuthSignUpRequest.Options(userAttributes: attributes)
            
            return try await Amplify.Auth.signUp(username: username, password: password, options: options)
    }
    
//    func confirmSignUp(username: String, confirmationCode: String) async throws -> AuthConfirmSignUpResult {
//        return try await Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode)
//    }
    
    func signInWithEmail(email: String, password: String) async throws -> AuthSignInResult {
        return try await Amplify.Auth.signIn(username: email, password: password)
    }
    
    func signInWithPhoneNumber(phoneNumber: String, password: String) async throws -> AuthSignInResult {
        return try await Amplify.Auth.signIn(username: phoneNumber, password: password)
    }
    
    func signOut() async {
        let _ = await Amplify.Auth.signOut()
    }
    
    func getCurrentUser() async throws -> AuthUser? {
        return try await Amplify.Auth.getCurrentUser()
    }
}

