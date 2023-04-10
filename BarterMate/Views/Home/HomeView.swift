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
                MessageView(viewModel: MessageViewModel(chat: GlobalState.shared.currentChat))
            case "Transaction":
                TransactionListView(viewModel: TransactionListViewModel(transactions: TransactionList.of(userId: viewModel.user.id), user: viewModel.user))
            default:
                EmptyView()
            }
            NavBarView(state: $state)
            
        }.navigationBarBackButtonHidden(true)
    }
}
