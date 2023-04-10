//
//  MyPostingListView.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import SwiftUI

struct MyPostingListView: View {
    
    @ObservedObject var viewModel: ListViewModel<BarterMatePosting>
    @State private var addPosting = false
    
    var body: some View {
        VStack {
            Text("Posting " + "\(viewModel.modelList.elements.count)")
                .font(.subheadline)
                .fontWeight(.bold)
            ScrollView(.vertical) {
                VStack {
                    LazyVStack {
                        ForEach(viewModel.modelList.elements, id: \.self) { posting in
                            PostingView(posting: posting, user: viewModel.user, parentViewModel: viewModel)
                        }
                    }.id(UUID())
                    
                    if viewModel.modelList.elements.count == 0 {
                       Text("No More Item")
                           .padding()
                    } else {

                    }
                }
            }
            ProfileButtonsView().onTapGesture {
                addPosting = true
            }
            NavigationLink(
                "",
                destination: LazyView {
                    ItemSelectionView(userid: viewModel.user.id, postingList: viewModel.modelList, addPosting: $addPosting)
                },
                isActive: $addPosting
            )
            .hidden()

        }


    }
}

struct MyPostingListView_Previews: PreviewProvider {
    
    static var postingList = ModelList<BarterMatePosting>.of(SampleUser.bill.id)
    
    static var viewModel = ListViewModel(user: SampleUser.bill, modelList: postingList)
    
    static var previews: some View {
        MyPostingListView(viewModel: viewModel)
    }
}

