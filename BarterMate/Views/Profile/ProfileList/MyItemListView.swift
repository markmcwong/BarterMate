//
//  MyItemListView.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import SwiftUI

struct MyItemListView: View {
    
    @ObservedObject var viewModel: ListViewModel<BarterMateItem>
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    ForEach(viewModel.modelList.elements, id: \.self) { item in
                        ItemCardView(item: item, parentViewModel: viewModel)
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

struct ItemListView_Previews: PreviewProvider {
    
    static var itemList = ModelList<BarterMateItem>.of(SampleUser.bill.id)
    
    static var viewModel = ListViewModel(user: SampleUser.bill, modelList: itemList)
    static var previews: some View {
        MyItemListView(viewModel: viewModel)
    }
}
