//
//  LoginView.swift
//  BarterMate
//
//  Created by Mark on 18/3/23.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel(authService: AmplifyAuthService())
    var onLoginSuccess: () -> Void
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .padding()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
            
            TextField("Phone Number", text: $viewModel.phoneNumber)
                .padding()
                .keyboardType(.phonePad)
            
            Button("Login with Email") {
                Task {
                    await viewModel.loginWithEmail()
                }
            }
            .padding()
            
            Button("Login with Phone Number") {
                Task {
                    await viewModel.loginWithPhoneNumber()
                }
            }
            .padding()
            
            Button("Sign Up") {
                Task {
                    await viewModel.signUp()
                }
            }
            .padding()
        }
        .padding()
    }
}
