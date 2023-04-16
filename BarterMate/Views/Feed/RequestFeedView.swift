//
//  RequestFeedView.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import SwiftUI

struct RequestFeedView: View {
    @ObservedObject var viewModel: RequestFeedViewModel

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    ForEach(viewModel.modelList.elements, id: \.self) { request in
                        if let user = viewModel.userIdToUser[request.ownerId] {
                            RequestCardView(request: request, user: user)
                        }
                    }

                }.id(UUID())

                if viewModel.modelList.elements.isEmpty {
                    Text("No More Request")
                        .padding()
                }

                Button("Refresh Request Feed") {
                    viewModel.refresh()
                }
            }
        }
        .refreshable {
            viewModel.refresh()
        }
    }

}

struct RequestFeedView_Previews: PreviewProvider {
    static var previews: some View {
        RequestFeedView(viewModel: RequestFeedViewModel(modelType: BarterMateRequest.self))
    }
}
