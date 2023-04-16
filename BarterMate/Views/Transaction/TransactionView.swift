//
//  TransactionView.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

import SwiftUI

struct TransactionView: View {
    @ObservedObject var viewModel: TransactionViewModel
    @State var addOffer = false
    @State var showModal = false
    @State var selectedItem: BarterMateItem?

    init(user: BarterMateUser, transaction: BarterMateTransaction) {
        self.viewModel = TransactionViewModel(user: user, transaction: transaction)
    }

    var body: some View {
        ZStack {
            VStack {
                Text("State: " + "\(viewModel.transaction.state)")
                List {
                    ForEach(Array(viewModel.transaction.participants), id: \.self) { participant in
                        Section(header: TransactionHeaderView(parentViewModel: viewModel, user: participant)) {
                            ForEach(Array(viewModel.userToItemsMap[participant.id] ?? []), id: \.self) { item in
                                HStack {
                                    Text(item.name)
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedItem = item
                                    showModal = true
                                }
                                .onLongPressGesture(minimumDuration: 2) {
                                    viewModel.removeItem(item: item)
                                    viewModel.update()
                                }
                                
                            }
                        }
                        
                    }
                }
            }.onAppear {
                print("view appear")
                viewModel.update()
            }.overlay(ModalView(displayView: {
                if let item = selectedItem {
                    ItemImageView(item: item)
                }
            }, showModal: $showModal))
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        addOffer = true
                    }) {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            }
        }.sheet(isPresented: $addOffer) {
            OfferSelectionView(userId: viewModel.user.id,
                               transaction: viewModel.transaction,
                               addOffer: $addOffer)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(user: SampleUser.bill, transaction: SampleTransaction.sampleTransaction)
    }
}
