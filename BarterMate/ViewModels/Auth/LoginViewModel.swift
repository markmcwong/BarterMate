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
    @Published var email: String = "markwongmanchun@gmail.com"
    @Published var password: String = "Testing123!"
    @Published var phoneNumber: String = ""
    @Published var username: String = ""
    @Published var errorMessage: String?
    @Published var confirmationCode: String = ""
    @Published var isLoggedIn = false

    private var user: BarterMateUser?
    private let authService: AuthService

    var homeViewModel: HomeViewModel {
        let viewModel = HomeViewModel(user: getUser())
        return viewModel
    }

    init(authService: AuthService) {
        self.authService = authService
    }

    func loginWithEmail() async {
        let res = await authService.signInWithEmail(email: email, password: password)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            successCallback()
        }
    }

    func loginWithPhoneNumber() async {
        let res = await authService.signInWithPhoneNumber(phoneNumber: phoneNumber, password: password)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            successCallback()
        }
    }

    func signUp() async {
        let res = await authService.signUp(username: username,
                                           email: email,
                                           phoneNumber: phoneNumber, password: password)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            successCallback()
        }
    }

    func confirmSignup() async {
        let res = await authService.confirmSignUp(email: email, confirmationCode: confirmationCode)
        if !res.isSuccess {
            errorMessage = res.message
        } else {
            successCallback()
        }
    }

    func successCallback() {
        user = authService.getUser()
        isLoggedIn = true
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
