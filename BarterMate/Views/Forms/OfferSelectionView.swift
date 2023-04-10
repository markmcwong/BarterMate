//
//  OfferSelectionView.swift
//  BarterMate
//
//  Created by Zico on 9/4/23.
//

import SwiftUI

struct OfferSelectionView: View {
    @ObservedObject var viewModel: OfferSelectionViewModel
    @Binding var addOffer: Bool
    
    init(userId: Identifier<BarterMateUser>, transaction: BarterMateTransaction, addOffer: Binding<Bool>) {
        viewModel = OfferSelectionViewModel(userId: userId, transaction: transaction)
        self._addOffer = addOffer
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.filteredItems, id: \.self) { item in
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
            
            Button("Offer item in transaction") {
                guard viewModel.highlightedItem != nil else {
                    return
                }
                viewModel.offerItem()
                addOffer = false
            }
        }
    }
}

struct OfferSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        OfferSelectionView(userId: SampleUser.bill.id, transaction: SampleTransaction.sampleTransaction, addOffer: .constant(true))
    }
}

