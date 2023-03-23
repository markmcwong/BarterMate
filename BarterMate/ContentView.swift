//
//  ContentView.swift
//  BarterMate
//
//  Created by mark on 12/3/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router.singleton
    var globalState = GlobalState.shared

    var body: some View {
        VStack {
            switch router.currentScreen {
            case .home:
                LoginView(onLoginSuccess: {
                    router.navigate(to: .home)
//                    appState.isLoggedIn = true
                })
            case .login:
                ListView<Item, ItemCardView>()
                
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
