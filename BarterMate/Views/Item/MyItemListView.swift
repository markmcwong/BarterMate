//
//  MyItemListView.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import SwiftUI

struct MyItemListView: View {
    
    @StateObject var viewModel: UserProfileViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    ForEach(viewModel.itemList.items, id: \.self) { item in
                        MyItemCardView(item: item)
                    }
                }.id(UUID())
                
//               if viewModel.loadedItems.count == 0 {
//                   Text("No More Item")
//                       .padding()
//                } else {
//
//                }
            }
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    
    static let viewModel = { () -> UserProfileViewModel in
        var viewModel = UserProfileViewModel(user: SampleUser.bill)
        viewModel.itemList.items = [SampleItem.guitar, SampleItem.waterBottle]
        return viewModel
    }()
    
    static var previews: some View {
        MyItemListView(viewModel: viewModel)
    }
}
