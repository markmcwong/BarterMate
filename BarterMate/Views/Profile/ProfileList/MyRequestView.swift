//  MyRequestView.swift
//  BarterMate
//
//  Created by Zico on 2/4/23.
//

import SwiftUI

struct MyRequestListView: View {

    @ObservedObject var viewModel: ListViewModel<BarterMateRequest>
    @State var showModal = false

    var body: some View {
        VStack {
            Text("Request " + "\(viewModel.modelList.elements.count)")
                .font(.subheadline)
                .fontWeight(.bold)

            ScrollView(.vertical) {
                VStack {
                    LazyVStack {
                        ForEach(viewModel.modelList.elements, id: \.self) { request in
                            RequestCardView(request: request, user: viewModel.user, parentViewModel: viewModel)
                        }
                    }.id(UUID())

                    if viewModel.modelList.elements.isEmpty {
                       Text("No Request")
                           .padding()
                    }
                }
            }

            ProfileButtonsView().onTapGesture {
                showModal = true
            }
        }
        .overlay(ModalView(displayView: {
            AddRequestFormView(ownerId: viewModel.user.id, requestList: viewModel.modelList, showModal: $showModal)
        }, showModal: $showModal))
    }
}

struct MyRequestListView_Previews: PreviewProvider {

    static var postingList = ModelList<BarterMatePosting>.of(SampleUser.bill.id)

    static var viewModel = ListViewModel(user: SampleUser.bill, modelList: postingList)

    static var previews: some View {
        MyPostingListView(viewModel: viewModel)
    }
}
