//
//  AmplifyTransactionList.swift
//  BarterMate
//
//  Created by Zico on 7/4/23.
//

import Amplify
import os.log

class AmplifyTransactionListFacade: AmplifyListFacade<BarterMateTransaction> {
    override func getEveryoneModels() {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            
            let transactions = try await Amplify.DataStore.query(Transaction.self)
        
            for transaction in transactions {
                try await transaction.users?.fetch()
                try await transaction.itemPool?.fetch()
            }
            
            let barterMateTransactions = transactions.compactMap {
                AmplifyTransactionConverter.toBarterMateModel(transaction: $0)
            }
            
            delegate.insertAll(models: barterMateTransactions)
        }
    }
    
    override func getModelsById(of userId: Identifier<BarterMateUser>) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            guard let user = try await Amplify.DataStore.query(User.self, byId: userId.value) else {
                return
            }
            
            guard let amplifyUserTransactions = user.Transactions else {
                return
            }
            
            try await amplifyUserTransactions.fetch()
            
            let amplifyTransactions = amplifyUserTransactions.compactMap {
                $0.transaction
            }
            
            for transaction in amplifyTransactions {
                try await transaction.users?.fetch()
                try await transaction.itemPool?.fetch()
            }

            let barterMateTransactions = amplifyTransactions.compactMap {
                AmplifyTransactionConverter.toBarterMateModel(transaction: $0)
            }
            print(amplifyTransactions.count, barterMateTransactions.count)
            
            delegate.insertAll(models: barterMateTransactions)
        }
    }

}


