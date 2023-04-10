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
    
    var body: some View {
   
        VStack {
            SwiftUI.Group {
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                
                TextField("Phone Number", text: $viewModel.phoneNumber)
                    .padding()
                    .keyboardType(.phonePad)
                
                TextField("User Name", text: $viewModel.username)
                    .padding()
                    .keyboardType(.default)
            }

            if viewModel.errorMessage != nil {
                Text(viewModel.errorMessage!).foregroundColor(.orange).font(.system(size: 12)).padding()
            }
            
            Button("Login with Email") {
                Task {
                    await viewModel.signOut()
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
            
            TextField("Confirmation Code", text: $viewModel.confirmationCode)
                .padding()
                .keyboardType(.numberPad)
            
            Button("Confirm Sign Up") {
                Task {
                    await viewModel.confirmSignup()
                }
            }
            .padding()
            
            NavigationLink(
                "",
                destination: LazyView {
                    HomeView(viewModel: viewModel.homeViewModel)
                },
                isActive: $viewModel.isLoggedIn
            )
            .hidden()

        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        

    }
}
