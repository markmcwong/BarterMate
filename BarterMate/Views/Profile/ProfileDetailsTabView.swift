//
//  ProfileDetailsTabView.swift
//  BarterMate
//
//  Created by Zico on 6/4/23.
//

import SwiftUI

struct ProfileDetailsTabView: View {
    @State private var selection = 1;
    @ObservedObject var viewModel: UserProfileViewModel
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                MyItemListView(viewModel: ListViewModel(user: viewModel.user, modelList: viewModel.itemList))
                    .tabItem {
                        Image(systemName: "shippingbox")
                        Text("Items")
                    }
                    .tag(1)
                MyPostingListView(viewModel: ListViewModel(user: viewModel.user, modelList: viewModel.postingList))
                    .tabItem {
                        Image(systemName: "signpost.and.arrowtriangle.up")
                        Text("Posting")
                    }
                    .tag(2)
                MyRequestListView(viewModel: ListViewModel(user: viewModel.user, modelList: viewModel.requestList))
                    .tabItem {
                        Image(systemName: "questionmark.square")
                        Text("Request")
                    }
                    .tag(3)
            }
//            ProfileButtonsView().onTapGesture {
//                showModal = true
//            }
        }



    }
}

struct ProfileDetailsTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailsTabView(viewModel: UserProfileViewModel(user: SampleUser.bill))
    }
}


