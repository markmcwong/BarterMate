//
//  AmplifyAuthService.swift
//  BarterMate
//
//  Created by Mark on 17/3/23.
//

import Foundation
import Amplify

public class AmplifyAuthService: AuthService {
    
    func signUp(username: String, email: String, phoneNumber: String, password: String) async -> ActionResult {
            let attributes = [
                AuthUserAttribute(.email, value: email),
                AuthUserAttribute(.phoneNumber, value: phoneNumber),
                AuthUserAttribute(.preferredUsername, value: username)
            ]
            let options = AuthSignUpRequest.Options(userAttributes: attributes)
        
        do {
            let res = try await Amplify.Auth.signUp(username: email, password: password, options: options)
            return ActionResult(res.isSignUpComplete, res.isSignUpComplete ? "" : "Invalid Credentials")
        } catch let error as AuthError {
            return ActionResult(false, "Signup failed with error: \(error)")
        } catch {
            return ActionResult(false, "Unexpected error: \(error)")
        }
    }
    
    func confirmSignUp(email: String, confirmationCode: String) async -> ActionResult{
        do {
            let res = try await Amplify.Auth.confirmSignUp(for: email, confirmationCode: confirmationCode)
            return ActionResult(res.isSignUpComplete, res.isSignUpComplete ? "" : "Invalid Credentials")
        } catch let error as AuthError {
            return ActionResult(false, "Signup failed with error: \(error)")
        } catch {
            return ActionResult(false, "Unexpected error: \(error)")
        }
    }
    
    func signInWithEmail(email: String, password: String) async -> ActionResult {
        do {
            let res = try await Amplify.Auth.signIn(username: email, password: password)
            print(res.isSignedIn, res)
            return ActionResult(res.isSignedIn, res.isSignedIn ? "" : "Invalid Credentials")
        } catch let error as AuthError {
            print(error.errorDescription)
            return ActionResult(false, "Sign in failed with error: \(error)")
        } catch {
            return ActionResult(false, "Unexpected error: \(error)")
        }
    }
    
    func signInWithPhoneNumber(phoneNumber: String, password: String) async -> ActionResult {
        do {
            let res = try await Amplify.Auth.signIn(username: phoneNumber, password: password)
            return ActionResult(res.isSignedIn, res.isSignedIn ? "" : "Invalid Credentials")
        } catch let error as AuthError {
            return ActionResult(false, "Sign in failed with error: \(error)")
        } catch {
            return ActionResult(false, "Unexpected error: \(error)")
        }
    }
    
    func signOut() async {
        let _ = await Amplify.Auth.signOut()
    }
    
    func getCurrentUser() async throws -> AuthUser? {
        return try await Amplify.Auth.getCurrentUser()
    }
}

