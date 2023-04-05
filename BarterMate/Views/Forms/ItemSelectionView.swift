//
//  ItemSelectionView.swift
//  BarterMate
//
//  Created by Zico on 6/4/23.
//

import SwiftUI

struct ItemSelectionView: View {
    
    @ObservedObject var viewModel: ItemSelectionViewModel
    
    init(userid: Identifier<BarterMateUser>) {
        viewModel = ItemSelectionViewModel(userid: userid)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.itemList.elements, id: \.self) { item in
                    ItemCardView(item: item)
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

struct ItemSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSelectionView(userid: SampleUser.bill.id)
    }
}
