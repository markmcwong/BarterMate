//
//  AmplifyTransactionList.swift
//  BarterMate
//
//  Created by Zico on 7/4/23.
//

import Amplify
import os.log

class AmplifyTransactionListFacade: TransactionListFacade {

    var delegate: (any TransactionListFacadeDelegate)?
    
    func setDelegate(delegate: any TransactionListFacadeDelegate) {
        guard delegate is TransactionList else {
            print("Incorrect delegate type")
            return
        }
        
        self.delegate = delegate
    }
    
    func save(model: BarterMateTransaction) {

        Task {
            do {
                guard let amplifyTransaction = AmplifyConverter.toAmplifyModel(model: model) else {
                    return
                }
                _ = try await Amplify.DataStore.save(amplifyTransaction)
                print("saved transaction")
            } catch {
                os_log("Error saving item into Amplify")
            }
        }
    }
    
    func delete(model: BarterMateTransaction) {
        Task {
            do {
                guard let amplifyModel = AmplifyConverter.toAmplifyModel(model: model) else {
                    return
                }
                _ = try await Amplify.DataStore.delete(amplifyModel)
                
            } catch {
                os_log("Error deleting item from Amplify")
            }
        }
    }
    
    func getAll() {
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
            
            delegate.insertAll(transactions: barterMateTransactions)
        }
    }
    
    private func fetchDetail(transaction: Transaction) async {
        do {
            try await transaction.users?.fetch()
            try await transaction.itemPool?.fetch()
        } catch {
            print("Failed to fetch detail")
        }
    }
    
    func getModelsWithUser(of userId: Identifier<BarterMateUser>) {
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
            
            delegate.insertAll(transactions: barterMateTransactions)
        }
    }

}


