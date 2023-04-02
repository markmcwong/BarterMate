//
//  RequestFeedView.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import SwiftUI

struct RequestFeedView: View {
    @ObservedObject var viewModel = RequestFeedViewModel(modelType: BarterMateRequest.self)
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    ForEach(viewModel.modelList.elements, id: \.self) { request in
                        if var user = viewModel.userIdToUser[request.ownerId] {
                            RequestCardView(request: request, user: user)
                        }
                    }
                }.id(UUID())

//                if !viewModel.requestList.e {
//                    Text("Loading Request")
//                        .padding()
//                } else
                if viewModel.modelList.elements.count == 0 {
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
