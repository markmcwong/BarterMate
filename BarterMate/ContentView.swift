//
//  ContentView.swift
//  BarterMate
//
//  Created by mark on 12/3/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router()
//    @StateObject var appState = AppState()

    var body: some View {
        VStack {
            switch router.currentScreen {
            case .login:
                LoginView(onLoginSuccess: {
//                    appState.isLoggedIn = true
                })
//            case .home:
//                HomeView()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
    @StateObject private var router = Router.singleton
//    @StateObject var appState = AppState()

    var body: some View {
        VStack {
            switch router.currentScreen {
            case .login:
                LoginView(onLoginSuccess: {
                    router.navigate(to: .login)
//                    appState.isLoggedIn = true
                })
            case .home:
                HomeView()
//                    .onSignOut {
//                        router.navigate(to: .login)
//                    }
//            case .profile:
//                ProfileView()
//                    .onSignOut {
//                        router.navigate(to: .login)
//                    }
            // Add other cases for different screens as needed
            }
        }
//        .environmentObject(appState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
