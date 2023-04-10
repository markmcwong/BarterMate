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
            switch state {
            case "Profile":
                UserProfileView(viewModel: UserProfileViewModel(user: viewModel.user))
            case "Request":
                RequestFeedView(viewModel: viewModel.requestFeedViewModel)
            case "Posting":
                PostingFeedView(viewModel: viewModel.postingFeedViewModel)
            case "Chat":
                ChatListView()
            case "Message":
//                EmptyView()
                MessageView(viewModel: MessageViewModel(chat: GlobalState.shared.currentChat))
            default:
                UserProfileView(viewModel: UserProfileViewModel(user: viewModel.user))
            }
            NavBarView(state: $state)

        }.navigationBarBackButtonHidden(true)
    }
}
