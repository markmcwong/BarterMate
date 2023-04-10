//
//  TransactionListView.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

import SwiftUI

struct TransactionListView: View {
    
    @ObservedObject var viewModel: TransactionListViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVStack {
                    ForEach(viewModel.transactions.transactions, id: \.self) { transaction in
                        TransactionCardView(user: viewModel.user, transaction: transaction)
                    }.id(UUID())
                    
                    
                    if viewModel.transactions.transactions.count == 0 {
                        Text("No More Transaction")
                            .padding()
                    } else {
                        
                    }
                }
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: TransactionListViewModel(transactions: TransactionList.all(), user: SampleUser.bill))
    }
}

