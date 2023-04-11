//
//  MyItemListView.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import SwiftUI

struct MyItemListView: View {
    @State var showModal = false
    @ObservedObject var viewModel: ListViewModel<BarterMateItem>
    
    var body: some View {
        VStack {
            Text("Item " + "\(viewModel.modelList.elements.count)")
                .font(.subheadline)
                .fontWeight(.bold)
            ScrollView(.vertical) {
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
            ProfileButtonsView().onTapGesture {
                showModal = true
            }
        }
        .overlay(ModalView(displayView: {
            AddItemFormView(ownerId: viewModel.user.id, itemList: viewModel.modelList, showModal: $showModal)
        }, showModal: $showModal))
    }
}

struct ItemListView_Previews: PreviewProvider {
    
    static var itemList = ModelList<BarterMateItem>.of(SampleUser.bill.id)
    
    static var viewModel = ListViewModel(user: SampleUser.bill, modelList: itemList)
    static var previews: some View {
        MyItemListView(viewModel: viewModel)
    }
}

