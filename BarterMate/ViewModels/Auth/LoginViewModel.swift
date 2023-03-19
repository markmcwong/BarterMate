//
//  LoginViewModel.swift
//  BarterMate
//
//  Created by Mark on 18/3/23.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
    @Published var username: String = ""
    @Published var errorMessage: String?
    @Published var confirmationCode: String = ""

    private let authService: AuthService
    private let router: Router

    init(authService: AuthService, router: Router) {
        self.authService = authService
        self.router = router
    }
    
    func loginWithEmail() async {
        let res = await authService.signInWithEmail(email: email, password: password)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            DispatchQueue.main.async {
                self.router.navigate(to: .home)
            }
        }
    }
    
    func loginWithPhoneNumber() async {
        let res = await authService.signInWithPhoneNumber(phoneNumber: phoneNumber, password: password)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            DispatchQueue.main.async {
                self.router.navigate(to: .home)
            }
        }
    }
    
    func signUp() async {
        let res = await authService.signUp(username: username, email: email, phoneNumber: phoneNumber, password: password)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            DispatchQueue.main.async {
                self.router.navigate(to: .home)
            }
        }
    }
    
    func confirmSignup() async {
        print(username)
        let res = await authService.confirmSignUp(username: username, confirmationCode: confirmationCode)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            DispatchQueue.main.async {
                self.router.navigate(to: .home)
            }
        }
    }
}
