//
//  BarterMateList.swift
//  BarterMate
//
//  Created by Zico on 7/4/23.
//

import Combine

class TransactionList: TransactionListFacadeDelegate, ObservableObject {

    @Published var transactions: [BarterMateTransaction] = []
    
    var facade: TransactionListFacade?
    
    static func all() -> TransactionList {
        let transactionList = TransactionList()
        transactionList.facade = AmplifyTransactionListFacade()
        transactionList.facade?.setDelegate(delegate: transactionList)
        transactionList.facade?.getAll()
        return transactionList
    }
    
    static func of(userId: Identifier<BarterMateUser>) -> TransactionList {
        let transactionList = TransactionList()
        transactionList.facade = AmplifyTransactionListFacade()
        transactionList.facade?.setDelegate(delegate: transactionList)
        transactionList.facade?.getModelsWithUser(of: userId)
        return transactionList
    }

    func insert(transaction: BarterMateTransaction) {
        transactions.append(transaction)
        facade?.save(model: transaction)
    }
    
    func remove(transaction: BarterMateTransaction) {
        if let index = transactions.firstIndex(of: transaction) {
            self.transactions.remove(at: index)
        }
        facade?.delete(model: transaction)
    }
    
    func insertAll(transactions: [BarterMateTransaction]) {
        self.transactions.append(contentsOf: transactions)
    }
}

