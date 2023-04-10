//
//  AmplifyTransactionFacade.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//
import Amplify
import Combine

class AmplifyTransactionFacade: TransactionFacade {

    var delegate: TransactionFacadeDelegate?
    
    func setDelegate(delegate: TransactionFacadeDelegate) {
        self.delegate = delegate
    }
    
    func addUser(user: BarterMateUser) {
        guard let delegate = delegate else {
            return
        }
        Task {
            do {
                guard let amplifyUser = try await Amplify.DataStore.query(User.self, byId: user.id.value) else {
                    return
                }
                
                guard let amplifyTransaction = try await Amplify.DataStore.query(Transaction.self, byId: delegate.id.value) else {
                    return
                }
                
                let newUserTransaction = UserTransaction(user: amplifyUser,
                                                         transaction: amplifyTransaction)
                
                try await Amplify.DataStore.save(newUserTransaction)
            } catch {
                print("error in adding user into Transaction")
            }
        }
    }
    
    func removeUser(user: BarterMateUser) {
        guard let delegate = delegate else {
            return
        }
        Task {
            do {
                guard let amplifyTransaction = try await
                        Amplify.DataStore.query(Transaction.self, byId: delegate.id.value) else {
                    return
                }
                
                guard let userTransactions = amplifyTransaction.users else {
                    return
                }
                
        
                for record in userTransactions {
                    if record.user.id == user.id.value
                        && record.transaction.id == delegate.id.value {
                        
                        try await Amplify.DataStore.delete(UserTransaction.self, withId: record.id)
                        
                        }
                    }
                }
            }
        }
    
    func addItem(item: BarterMateItem) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            do {
                guard var amplifyItem = try await Amplify.DataStore.query(Item.self, byId: item.id.value) else {
                    return
                }
                
                amplifyItem.transactionID =  delegate.id.value
                
                try await Amplify.DataStore.save(amplifyItem)
            }
        }
    }
    
    func removeItem(item: BarterMateItem) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            do {
                guard var amplifyItem = try await Amplify.DataStore.query(Item.self, byId: item.id.value) else {
                    return
                }
                
                amplifyItem.transactionID = nil
                try await Amplify.DataStore.save(amplifyItem)
            }
        }
    }
    
    func lockTransaction() {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            do {
                guard var amplifyTransaction = try await Amplify.DataStore.query(Transaction.self, byId: delegate.id.value) else {
                    return
                }
                
                amplifyTransaction.status = .paymentPending
                
                try await Amplify.DataStore.save(amplifyTransaction)
                
            }
        }
    }
    
    func userLockTransaction(user: BarterMateUser) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            do {
                let userLocked = UserLocked(userId: user.id.value, locked: true)
                
                guard var amplifyTransaction = try await Amplify.DataStore.query(Transaction.self, byId: delegate.id.value) else {
                    return
                }
                
                amplifyTransaction.userLocked?.append(userLocked)
                
                try await Amplify.DataStore.save(amplifyTransaction)
                
            }
        }
    }
    
}
    

    


