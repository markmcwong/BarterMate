//
//  PostingListView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct PostingListView: View {
    @StateObject var viewModel = PostingListViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    ForEach(viewModel.loadedPostings.indices, id: \.self) { index in
                        PostingView(posting: viewModel.loadedPostings[index])
                    }
                }.id(UUID())
                
                if viewModel.loadedPostings.count == 0 {
                    Text("No More Postings")
                        .padding()
                } else {
                    
                }
            }

        }
    }
}

struct PostingListView_Previews: PreviewProvider {
    static var previews: some View {
        PostingListView()
    }
}

