//
//  UserSelectionViewModel.swift
//  BarterMate
//
//  Created by Zico on 12/4/23.
//

import Foundation

class UserSelectionViewModel: MultiSelectableItemViewModel<BarterMateUser> {
    var user: BarterMateUser
    var transactionList: TransactionList? = nil
    var chatList: ListViewModel<BarterMateChat>? = nil
    
    init(user: BarterMateUser, transactionList: TransactionList) {
        self.user = user
        self.transactionList = transactionList
        let userList = ModelList<BarterMateUser>.all()
        super.init(itemList: userList)
    }
    
    init(user: BarterMateUser, chatList: ListViewModel<BarterMateChat>) {
        self.user = user
        self.chatList = chatList
        let userList = ModelList<BarterMateUser>.all()
        super.init(itemList: userList)
    }
    
    var filteredUsers: [BarterMateUser] {
        itemList.elements.filter { $0.id != user.id }
    }
    
    func createTransaction(callback: () -> Void) {
        guard selectedItem.count >= 1 else {
            return
        }
        
        guard let transactionList = transactionList else {
            return
        }
        
        let transaction = BarterMateTransaction.createNewTransaction()
        transactionList.insert(transaction: transaction)
        
        for user in selectedItem {
            transaction.addUser(user: user)
        }
        
        transaction.addUser(user: user)
        callback()
    }
    
    func createChat(name: String, callback: () -> Void) {
        guard selectedItem.count >= 1 else {
            return
        }
        
        guard !name.isEmpty else {
            return
        }
        
        guard let chatList = chatList else {
            return
        }
        
        let chat = BarterMateChat(name: name, messages: [], users: Array(selectedItem))
        chatList.saveItem(item: chat)
        let chatUsers = selectedItem.map { AmplifyUserChatAdapter.toAmplifyModel(user: $0, chat: chat)}
        print("Converted chatUsers are ", chatUsers)
        ChatService.insertUserChats(userChats: chatUsers)
        callback()
    }
}

