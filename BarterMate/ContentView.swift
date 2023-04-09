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
        NavigationView {
//            LoginView()
            HomeView(viewModel: HomeViewModel(user: AmplifyUserConverter.toBarterMateModel(user: User(id: "213f11fc-0384-4c44-a8c0-e87f1b77b41e", username: "Lawrence"))!))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
