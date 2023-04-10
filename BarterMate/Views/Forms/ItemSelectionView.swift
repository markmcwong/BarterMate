//
//  ItemSelectionView.swift
//  BarterMate
//
//  Created by Zico on 6/4/23.
//

import SwiftUI

struct ItemSelectionView: View {
    
    @ObservedObject var viewModel: ItemSelectionViewModel
    @Binding var addPosting: Bool
    
    init(userid: Identifier<BarterMateUser>, postingList: ModelList<BarterMatePosting>, addPosting: Binding<Bool>) {
        viewModel = ItemSelectionViewModel(userid: userid, postingList: postingList)
        self._addPosting = addPosting
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.filteredItemLists, id: \.self) { item in
                    if viewModel.highlightedItem == item {
                        ItemCardView(item: item)
                            .border(Color(.red))
                            .onTapGesture {
                                viewModel.highlightedItem = nil
                            }
                    } else {
                        ItemCardView(item: item)
                            .onTapGesture {
                                viewModel.highlightedItem = item
                            }
                    }

                }
            }.id(UUID())
            
            if viewModel.itemList.elements.count == 0 {
               Text("No More Item")
                   .padding()
            } else {

            }
            
            Button("Make Posting") {
                guard viewModel.highlightedItem != nil else {
                    return
                }
                viewModel.makePosting()
                addPosting = false
            }
        }
    }
}

struct ItemSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSelectionView(userid: SampleUser.bill.id, postingList: ModelList<BarterMatePosting>.empty(), addPosting: .constant(true))
    }
}
