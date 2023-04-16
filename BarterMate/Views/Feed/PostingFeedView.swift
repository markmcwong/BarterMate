//
//  PostingFeedView.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import SwiftUI

struct PostingFeedView: View {
    @ObservedObject var viewModel: PostingFeedViewModel

    var body: some View {

        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    ForEach(viewModel.modelList.elements, id: \.self) { posting in
                        if let user = viewModel.userIdToUser[posting.item.ownerId] {
                            PostingView(posting: posting, user: user)
                        }
                    }

                }.id(UUID())

                if viewModel.modelList.elements.isEmpty {
                    Text("No More Postings")
                        .padding()
                }

                Button {
                    viewModel.refresh()
                } label: {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                }
            }.padding(10)
        }
        .refreshable {
            viewModel.refresh()
        }
    }
}

struct PostingFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PostingFeedView(viewModel: PostingFeedViewModel(modelType: BarterMatePosting.self))
    }
}
