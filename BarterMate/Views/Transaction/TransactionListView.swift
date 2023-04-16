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
        ZStack {
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
            }
            .onAppear {
                viewModel.refresh()
            }
            .refreshable {
                viewModel.refresh()
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        addTransaction = true
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
        }.sheet(isPresented: $addTransaction) {
            UserSelectionView(user: viewModel.user!,
                              transactionList: viewModel.modelList,
                              addTransaction: $addTransaction)
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: TransactionListViewModel(transactions: TransactionList.all(),
                                                                user: SampleUser.bill))
    }
}
