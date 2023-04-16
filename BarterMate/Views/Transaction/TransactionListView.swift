//
//  TransactionListView.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

import SwiftUI

struct TransactionListView: View {

    @ObservedObject var viewModel: TransactionListViewModel
    @State private var addTransaction = false

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack {
                    LazyVStack {
                        ForEach(viewModel.modelList.elements, id: \.self.id) { transaction in
                            TransactionCardView(user: viewModel.user!, transaction: transaction)
                        }.id(UUID())
                    }
                }
            }
            ProfileButtonsView().onTapGesture {
                addTransaction = true
            }
            NavigationLink(
                "",
                destination: LazyView {
                    UserSelectionView(user: viewModel.user!,
                                      transactionList: viewModel.modelList,
                                      addTransaction: $addTransaction)
                },
                isActive: $addTransaction
            )
            .hidden()
        }
        .onAppear {
            viewModel.refresh()
        }
        .refreshable {
            viewModel.refresh()
        }

    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: TransactionListViewModel(transactions: TransactionList.all(),
                                                                user: SampleUser.bill))
    }
}
