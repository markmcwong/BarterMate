//
//  UserProfileView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct UserProfileView: View {
    
    @State var showModal: Bool = false
    @ObservedObject var viewModel: UserProfileViewModel
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ScrollViewReader { scrollView in
                    LazyVStack {
                        UserProfileImageView()
                            .frame(width: 200,  height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(lineWidth: 1))
                        Text(viewModel.user.username)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        MyItemListView(viewModel: ItemListViewModel(user: viewModel.user, itemList: viewModel.itemList))
                    }
                }
            }
            ProfileButtonsView().onTapGesture {
                showModal = true
            }
        }.overlay(ModalView(displayView: {
            FormView(viewModel: AddItemFormViewModel(itemList: viewModel.itemList,
                                                     ownerId: viewModel.user.id),
                     showModal: $showModal)
        }, showModal: $showModal))
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static let viewModel = { () -> UserProfileViewModel in
        var viewModel = UserProfileViewModel(user: SampleUser.bill)
        return viewModel
    }()
    
    static var previews: some View {
        UserProfileView(viewModel: viewModel)
    }
}

