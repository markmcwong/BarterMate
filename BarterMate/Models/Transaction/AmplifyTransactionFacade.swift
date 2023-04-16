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
    
    func createTransaction(transaction: BarterMateTransaction) {
        Task {
            do {
                let amplifyTransaction = AmplifyTransactionConverter.toAmplifyModel(transaction: transaction)
                
                try await Amplify.DataStore.save(amplifyTransaction)

                for user in transaction.participants {
                    addUser(user: user)
                }
            } catch {
                print("error creating transaction")
            }
        }
    }
    
    func addUser(user: BarterMateUser) {
        guard let delegate = delegate else {
            print("no delegate")
            return
        }
        Task {
            do {
                guard let amplifyUser = try await Amplify.DataStore.query(User.self, byId: user.id.value) else {
                    print("cannot find user")
                    return
                }
                
                guard let amplifyTransaction = try await Amplify.DataStore.query(Transaction.self, byId: delegate.id.value) else {
                    print("cannot find transaction")
                    return
                }
                
                let newUserTransaction = UserTransaction(user: amplifyUser,
                                                         transaction: amplifyTransaction)
                
                try await Amplify.DataStore.save(newUserTransaction)
                
                try await Amplify.DataStore.save(amplifyTransaction)
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
    
    func completeTransaction() {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            do {
                guard var amplifyTransaction = try await Amplify.DataStore.query(Transaction.self, byId: delegate.id.value) else {
                    return
                }
                
                amplifyTransaction.status = .completed
                
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
    
    func userCompleteBarter(user: BarterMateUser) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            do {
                let userCompleted = UserCompleted(userId: user.id.value, completed: true)
                
                guard var amplifyTransaction = try await Amplify.DataStore.query(Transaction.self, byId: delegate.id.value) else {
                    return
                }
                
                amplifyTransaction.userCompleted?.append(userCompleted)
                
                try await Amplify.DataStore.save(amplifyTransaction)
            }
        }
    }
    
}
