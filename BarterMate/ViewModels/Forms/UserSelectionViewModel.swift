//
//  UserSelectionViewModel.swift
//  BarterMate
//
//  Created by Zico on 12/4/23.
//

import Foundation

class UserSelectionViewModel: MultiSelectableItemViewModel<BarterMateUser> {
    var user: BarterMateUser
    var transactionList: TransactionList
    
    init(user: BarterMateUser, transactionList: TransactionList) {
        self.user = user
        self.transactionList = transactionList
        let userList = ModelList<BarterMateUser>.all()
        super.init(itemList: userList)
    }
    
    var filteredUsers: [BarterMateUser] {
        itemList.elements.filter { $0.id != user.id }
    }
    
    func createTransaction() {
        guard selectedItem.count >= 1 else {
            return
        }
        
        let transaction = BarterMateTransaction.createNewTransaction()
        transactionList.insert(transaction: transaction)
        
        for user in selectedItem {
            transaction.addUser(user: user)
        }
        
        transaction.addUser(user: user)
    }
}
