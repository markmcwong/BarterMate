//
//  RequestListView.swift
//  BarterMate
//
//  Created by Zico on 16/3/23.
//

import SwiftUI

struct RequestListView: View {
    @StateObject var viewModel = RequestListViewModel()

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    ForEach(viewModel.loadedRequests.indices, id: \.self) { index in
                        RequestCardView(request: viewModel.loadedRequests[index])
                    }
                }.id(UUID())
                
                if viewModel.loadedRequests.count == 0 {
                    Text("No More Request")
                        .padding()
                } else {
                    
                }
            }
        }
    }
}

struct RequestListView_Previews: PreviewProvider {
    static var previews: some View {
        RequestListView()
    }
}
