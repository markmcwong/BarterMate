//
//  SelectUser.swift
//  BarterMate
//
//  Created by Zico on 12/4/23.
//

import SwiftUI

struct UserSelectionView: View {
    
    @ObservedObject var viewModel: UserSelectionViewModel
    @Binding var addTransaction: Bool
    
    init(user: BarterMateUser, transactionList: TransactionList, addTransaction: Binding<Bool>) {
        self.viewModel = UserSelectionViewModel(user: user, transactionList: transactionList)
        self._addTransaction = addTransaction
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(viewModel.filteredUsers, id: \.self) { user in
                        if viewModel.selectedItem.contains(user) {
                            UserCardView(item: user)
                                .border(Color(.red))
                                .onTapGesture {
                                    viewModel.unSelectItem(item: user)
                                }
                        } else {
                            UserCardView(item: user)
                                .onTapGesture {
                                    viewModel.selectItem(item: user)
                                }
                        }
                    }
                }.id(UUID())
                
                Button("Make transactions with highlighted user") {
                    viewModel.createTransaction()
                    addTransaction = false
                }
            }
        }

    }
    
}

//struct SelectUser_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectUser()
//    }
//}

