//
//  MyItemListView.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import SwiftUI

struct MyItemListView: View {
    
    @ObservedObject var viewModel: UserProfileViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    Text("\(viewModel.itemList.elements.count)")
                    ForEach(viewModel.itemList.elements, id: \.self) { item in
                        MyItemCardView(item: item)
                    }
                }.id(UUID())
                
                if viewModel.itemList.elements.count == 0 {
                   Text("No More Item")
                       .padding()
                } else {

                }
            }
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    
    static let viewModel = { () -> UserProfileViewModel in
        var viewModel = UserProfileViewModel(user: SampleUser.bill)
        viewModel.itemList.elements = [SampleItem.guitar, SampleItem.waterBottle]
        return viewModel
    }()
    
    static var previews: some View {
        MyItemListView(viewModel: viewModel)
    }
}
