//
//  MyRequestView.swift
//  BarterMate
//
//  Created by Zico on 2/4/23.
//

import SwiftUI

struct MyRequestListView: View {
    
    @ObservedObject var viewModel: ListViewModel<BarterMateRequest>
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    ForEach(viewModel.modelList.elements, id: \.self) { request in
                        RequestCardView(request: request, user: viewModel.user!)
                    }
                }.id(UUID())
                
                if viewModel.modelList.elements.count == 0 {
                   Text("No More Item")
                       .padding()
                } else {

                }
            }
        }

    }
}

struct MyRequestListView_Previews: PreviewProvider {
    
    static var postingList = ModelList<BarterMatePosting>.of(SampleUser.bill.id)
    
    static var viewModel = ListViewModel(user: SampleUser.bill, modelList: postingList)
    
    static var previews: some View {
        MyPostingListView(viewModel: viewModel)
    }
}
