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
<<<<<<< Updated upstream
//         VStack {
//             switch router.currentScreen {
//             case .home:
//                 LoginView(onLoginSuccess: {
//                     router.navigate(to: .home)
// //                    appState.isLoggedIn = true
//                 })
//             case .login:
//                 RequestFeedView()
//                 //UserProfileView(viewModel: UserProfileViewModel(user: SampleUser.bill))
//             case .profile:
//                 UserProfileView(viewModel: UserProfileViewModel(user: SampleUser.bill))
//             case .request:
//                 RequestFeedView()
//             case .posting:
//                 PostingFeedView()
//             case .chat:
//                 ChatListView()
//             }
=======
        VStack {
            switch router.currentScreen {
            case .home:
                RequestFeedView()
            case .login:
                LoginView(onLoginSuccess: {
                    router.navigate(to: .home)
//                    appState.isLoggedIn = true
                })
                //UserProfileView(viewModel: UserProfileViewModel(user: SampleUser.bill))
            case .profile:
                UserProfileView(viewModel: UserProfileViewModel(user: SampleUser.bill))
            case .request:
                RequestFeedView()
            case .posting:
                PostingFeedView()
            case .chat:
                ChatListView()
            }
>>>>>>> Stashed changes
            
//             if router.currentScreen != .home {
//                 NavBarView()
//             }
        NavigationView {
            LoginView()
        }
        .navigationViewStyle(StackNavigationViewStyle())

//        .environmentObject(appState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
