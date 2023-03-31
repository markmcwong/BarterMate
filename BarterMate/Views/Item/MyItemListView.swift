//
//  MyItemListView.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import SwiftUI

struct MyItemListView: View {
    
    @ObservedObject var viewModel: ItemListViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    Text("\(viewModel.itemList.elements.count)")
                    ForEach(viewModel.itemList.elements, id: \.self) { item in
                        MyItemCardView(item: item, parentViewModel: viewModel)
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
    
    static var itemList = ModelList<BarterMateItem>.of(SampleUser.bill.id)
    
    static var previews: some View {
        MyItemListView(viewModel: ItemListViewModel(user: SampleUser.bill, itemList: itemList))
    }
}
