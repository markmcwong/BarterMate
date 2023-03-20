//
//  ChatListView.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

import Foundation
import SwiftUI

struct ChatListView: View {
    @StateObject var viewModel = ChatListViewModel()

    var body: some View {
        VStack {
            //            LazyVStack {
            //                ForEach(viewModel.loadedPostings.indices, id: \.self) { index in
            //                    PostingView(posting: viewModel.loadedPostings[index])
            //                }
            //            }.id(UUID())
            //
            //            if viewModel.loadedPostings.count == 0 {
            //                Text("No More Postings")
            //                    .padding()
            //            } else {
            //            }
        }
        .navigationBarTitle("Chats")
//        .onAppear(perform: viewModel.loadChats)
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
