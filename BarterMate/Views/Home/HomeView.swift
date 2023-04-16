//
//  HomeView.swift
//  BarterMate
//
//  Created by Mark on 19/3/23.
//

import Foundation
import SwiftUI

enum AppState {
    case profile
    case request
    case posting
    case chat
    case message
    case transaction
}

struct HomeView: View {
    @StateObject private var router = Router.singleton
    let viewModel: HomeViewModel
    @State var state: AppState = .profile
    
    var body: some View {
        VStack {
            switch state {
            case .profile:
                UserProfileView(viewModel: UserProfileViewModel(user: viewModel.user))
            case .request:
                RequestFeedView(viewModel: viewModel.requestFeedViewModel)
            case .posting:
                PostingFeedView(viewModel: viewModel.postingFeedViewModel)
            case .chat:
                ChatListView()
            case .message:
                MessageView(viewModel: MessageViewModel(chat: GlobalState.shared.currentChat))
            case .transaction:
                TransactionListView(viewModel: TransactionListViewModel(transactions: TransactionList.of(userId: viewModel.user.id), user: viewModel.user))
            default:
                EmptyView()
            }
            NavBarView(state: $state)
            
        }.navigationBarBackButtonHidden(true)
    }
}
