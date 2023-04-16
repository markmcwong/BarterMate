//
//  SelectUser.swift
//  BarterMate
//
//  Created by Zico on 12/4/23.
//

import SwiftUI

struct UserSelectionView: View {
    @State private var inputText = ""
    @ObservedObject var viewModel: UserSelectionViewModel
    @Binding var addItem: Bool
    let isForChat: Bool
    
    init(user: BarterMateUser, transactionList: ModelList<BarterMateTransaction>, addTransaction: Binding<Bool>) {
        self.viewModel = UserSelectionViewModel(user: user, transactionList: transactionList)
        self._addItem = addTransaction
        self.isForChat = false
    }
    
    init(user: BarterMateUser, chatList: ModelList<BarterMateChat>, addChat: Binding<Bool>) {
        self.viewModel = UserSelectionViewModel(user: user, chatList: chatList)
        self._addItem = addChat
        self.isForChat = true
    }
    
    
    var body: some View {
        VStack {
            if(isForChat) {
                TextField("Enter chat name...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach((isForChat ? viewModel.itemList.elements : viewModel.filteredUsers), id: \.self) { user in
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
                
                Button("Create \(isForChat ? "Chat" : "Transactions" ) with highlighted user") {
                    if(isForChat) {
                        viewModel.createChat(name: inputText, callback: {
                            addItem = false
                        })
                    } else {
                        viewModel.createTransaction(callback: {
                            addItem = false
                        })
                    }
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

