//
//  PostingListView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

//class PostingListView {
//    var test = GenericListView<Posting, View>()
//}
//
//struct PostingListView: View {
//    @StateObject var viewModel = GenericListViewModel(service: AmplifyGenericModelService<Posting>())
//
//    var body: some View {
//        ScrollView(.vertical) {
//            VStack {
//                LazyVStack {
//                    ForEach(viewModel.loadedObjects.indices, id: \.self) { index in
//                        PostingView(posting: viewModel.loadedObjects[index])
//                    }
//                }.id(UUID())
//
//                if viewModel.loadedObjects.count == 0 {
//                    Text("No More Postings")
//                        .padding()
//                } else {
//
//                }
//            }
//
//        }
//    }
//}
//
//struct PostingListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostingListView()
//    }
//}
//
