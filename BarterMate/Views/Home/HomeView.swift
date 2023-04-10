//
//  HomeView.swift
//  BarterMate
//
//  Created by Mark on 19/3/23.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject private var router = Router.singleton
    let viewModel: HomeViewModel
    @State var state: String = "Profile"

    var body: some View {
        VStack {
            Text(state)
            switch router.currentScreen {
            case .profile:
                UserProfileView(viewModel: UserProfileViewModel(user: viewModel.user))
            case .request:
                RequestFeedView(viewModel: viewModel.requestFeedViewModel)
            case .posting:
                PostingFeedView(viewModel: viewModel.postingFeedViewModel)
            case .chat:
                ChatListView()
            case .message:
//                EmptyView()
                MessageView(viewModel: MessageViewModel(chat: GlobalState.shared.currentChat))
            default:
                UserProfileView(viewModel: UserProfileViewModel(user: viewModel.user))
            }
            NavBarView(state: $state)

        }.navigationBarBackButtonHidden(true)
    }
}
