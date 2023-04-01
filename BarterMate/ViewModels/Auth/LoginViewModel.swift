//
//  LoginViewModel.swift
//  BarterMate
//
//  Created by Mark on 18/3/23.
//
import SwiftUI
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
    @Published var username: String = ""
    @Published var errorMessage: String?
    @Published var confirmationCode: String = ""   
    @Published var isLoggedIn: Bool = false

    private var user: BarterMateUser?
    private let authService: AuthService
    private let router: Router
    
    var homeViewModel: HomeViewModel {
        let viewModel = HomeViewModel(user: getUser())
        return viewModel
    }

    init(authService: AuthService, router: Router) {
        self.authService = authService
        self.router = router
    }
    
    func loginWithEmail() async {
        let res = await authService.signInWithEmail(email: email, password: password)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            user = authService.getUser()
            isLoggedIn = true
        }
    }
    
    func loginWithPhoneNumber() async {
        let res = await authService.signInWithPhoneNumber(phoneNumber: phoneNumber, password: password)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            user = authService.getUser()
            isLoggedIn = true
        }
    }
    
    func signUp() async {
        let res = await authService.signUp(username: username, email: email, phoneNumber: phoneNumber, password: password)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            user = authService.getUser()
            isLoggedIn = true
        }
    }
    
    func confirmSignup() async {
        let res = await authService.confirmSignUp(email: email, confirmationCode: confirmationCode)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            user = authService.getUser()
            isLoggedIn = true
        }
    }
    
    private func getUser() -> BarterMateUser {
        guard let user = self.user else {
            fatalError("User is nil")
        }
        return user
    }
    
    func signOut() async {
        await authService.signOut()
    }
}

