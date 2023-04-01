//
//  RequestFeedView.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import SwiftUI

struct RequestFeedView: View {
    @ObservedObject var viewModel = RequestFeedViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    ForEach(viewModel.requestList.elements, id: \.self) { request in
                        if let user = viewModel.userIdToUser[request.ownerId] {
                            RequestCardView(request: request, user: user)
                        }
                    }
                }.id(UUID())

//                if !viewModel.requestList.e {
//                    Text("Loading Request")
//                        .padding()
//                } else
                if viewModel.requestList.elements.count == 0 {
                    Text("No More Request")
                        .padding()
                } else {

                }
            }
        }
    }
    
}

struct RequestFeedView_Previews: PreviewProvider {
    static var previews: some View {
        RequestFeedView()
    }
}
