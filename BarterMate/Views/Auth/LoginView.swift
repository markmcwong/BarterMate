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
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                Divider()
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                Divider()
                
                TextField("Phone Number", text: $viewModel.phoneNumber)
                    .padding()
                    .keyboardType(.phonePad)
                Divider()
                
                TextField("User Name", text: $viewModel.username)
                    .padding()
                    .keyboardType(.default)
                Divider()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 10)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }
            
            Button(action: {
                Task {
                    await viewModel.signOut()
                    await viewModel.loginWithEmail()
                }
            }, label: {
                Text("Login with Email")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            
            Button(action: {
                Task {
                    await viewModel.loginWithPhoneNumber()
                }
            }, label: {
                Text("Login with Phone Number")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            
            Button(action: {
                Task {
                    await viewModel.signUp()
                }
            }, label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(10)
            })
            
            VStack(alignment: .leading, spacing: 5) {
                TextField("Confirmation Code", text: $viewModel.confirmationCode)
                    .padding()
                    .keyboardType(.numberPad)
                Divider()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 10)
//            .opacity(viewModel.isConfirmSignupVisible ? 1 : 0)
            
            Button(action: {
                Task {
                    await viewModel.confirmSignup()
                }
            }, label: {
                Text("Confirm Sign Up")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            })
//            .opacity(viewModel.isConfirmSignupVisible ? 1 : 0)
            
            Spacer()
            
            NavigationLink(
                 "",
                 destination: LazyView {
                     HomeView(viewModel: viewModel.homeViewModel)
                 },
                 isActive: $viewModel.isLoggedIn
             )
             .hidden()
        }
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Login")
    }
}
