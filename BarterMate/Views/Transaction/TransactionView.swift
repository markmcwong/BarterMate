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
    
    init(user: BarterMateUser, transaction: BarterMateTransaction) {
        self.viewModel = TransactionViewModel(user: user, transaction: transaction)
    }
    
    var body: some View {
        VStack {
            Text("State: " + "\(viewModel.transaction.state)")
            List {
                ForEach(Array(viewModel.transaction.participants ?? []), id: \.self) { participant in
                    Section(header: TransactionHeaderView(parentViewModel: viewModel, user: participant)) {
                        ForEach(Array(viewModel.userToItemsMap[participant.id] ?? []), id: \.self) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onLongPressGesture(minimumDuration: 2) {
                                    viewModel.removeItem(item: item)
                                    viewModel.update()
                                }

                        }
                    }
                    
                }
            }
            ProfileButtonsView().onTapGesture {
                addOffer = true
            }
            NavigationLink(
                "",
                destination: LazyView {
                    OfferSelectionView(userId: viewModel.user.id,
                                       transaction: viewModel.transaction,
                                       addOffer: $addOffer)
                },
                isActive: $addOffer
            )
            .hidden()
        }.onAppear {
            print("view appear")
            viewModel.update()
        }

    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(user: SampleUser.bill, transaction: SampleTransaction.sampleTransaction)
    }
}

