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


    var body: some View {
        VStack {
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
                MessageView(chat: GlobalState.shared.currentChat)
            }
            NavBarView()

        }
    }
}
