//
//  PostingFeedView.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import SwiftUI

struct PostingFeedView: View {
    @ObservedObject var viewModel = PostingFeedViewModel()
    
    var body: some View {
        VStack {
            LazyVStack {
                ForEach(viewModel.postingList.elements, id: \.self) { posting in
                    if let user = viewModel.userIdToUser[posting.item.ownerId] {
                        PostingView(posting: posting, user: user)
                    }
                }
            }.id(UUID())
            
            if viewModel.postingList.elements.count == 0 {
                Text("No More Postings")
                    .padding()
            } else {
                
            }
        }
    }
}

struct PostingFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PostingFeedView()
    }
}
