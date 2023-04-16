//
//  AmplifyAuthService.swift
//  BarterMate
//
//  Created by Mark on 17/3/23.
//

import Foundation
import Amplify

public class AmplifyAuthService: AuthService {

    var authUser: AuthUser?
    var username: String?
    var password: String?

    func signUp(username: String, email: String, phoneNumber: String, password: String) async -> ActionResult {
        let attributes = [
            AuthUserAttribute(.email, value: email),
            AuthUserAttribute(.phoneNumber, value: phoneNumber),
            AuthUserAttribute(.preferredUsername, value: username)
        ]
        let options = AuthSignUpRequest.Options(userAttributes: attributes)

        do {
            let res = try await Amplify.Auth.signUp(username: email, password: password, options: options)
            switch res.nextStep {
            case .confirmUser:
                self.username = username
                self.password = password
                return ActionResult(res.isSignUpComplete, "Confirm account with verification code")
            default:
                return ActionResult(res.isSignUpComplete, res.isSignUpComplete ? "" : "Invalid Credentials")
            }
        } catch let error as AuthError {
            return ActionResult(false, "Signup failed with error: \(error)")
        } catch {
            return ActionResult(false, "Unexpected error: \(error)")
        }
    }

        func confirmSignUp(email: String, confirmationCode: String) async -> ActionResult {
            do {
                await signOut()
                let res = try await Amplify.Auth.confirmSignUp(for: email, confirmationCode: confirmationCode)
            if res.isSignUpComplete {
                let signInRes = try await Amplify.Auth.signIn(username: email, password: password)
                if signInRes.isSignedIn {
                    let user = try await Amplify.Auth.getCurrentUser()
                    _ = try await Amplify.DataStore.save(User(id: user.userId, username: username))
                }
                return ActionResult(false, res.isSignUpComplete ? "Account is Confirmed." : "Invalid Credentials")
            }
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
            if res.isSignedIn {
                let user = try await Amplify.Auth.getCurrentUser()
                authUser = user
                GlobalState.shared.updateUser(userId: user.userId, user: User(id: user.userId, username: user.username))
            }
            return ActionResult(res.isSignedIn, res.isSignedIn ? "" : "Invalid Credentials")
        } catch let error as AuthError {
            return ActionResult(false, "Sign in failed with error: \(error)")
        } catch {
            return ActionResult(false, "Unexpected error: \(error)")
        }
    }

    func signInWithPhoneNumber(phoneNumber: String, password: String) async -> ActionResult {
        do {
            let res = try await Amplify.Auth.signIn(username: phoneNumber, password: password)
            if res.isSignedIn {
                let user = try await Amplify.Auth.getCurrentUser()
                authUser = user
            }
            return ActionResult(res.isSignedIn, res.isSignedIn ? "" : "Invalid Credentials")
        } catch let error as AuthError {
            return ActionResult(false, "Sign in failed with error: \(error)")
        } catch {
            return ActionResult(false, "Unexpected error: \(error)")
        }
    }

    func signOut() async {
        do {
            let _ = await Amplify.Auth.signOut()
        }
    }

    func getUser() -> BarterMateUser? {
        guard let authUser = authUser else {
            return nil
        }
        return BarterMateUser.getUserWithId(id: Identifier(value: authUser.userId))
    }

}
