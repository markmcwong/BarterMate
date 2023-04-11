//
//  AmplifyTransactionConverter.swift
//  BarterMate
//
//  Created by Zico on 7/4/23.
//

import Foundation

struct AmplifyTransactionConverter {
    
    static func toBarterMateModel(transaction: Transaction) -> BarterMateTransaction? {
        
        guard let amplifyUsers = transaction.users,
              let amplifyItems = transaction.itemPool,
              let status = transaction.status else {
            return nil
        }
        
        Task {
            try await amplifyUsers.fetch()
            try await amplifyItems.fetch()
        }
        
        let barterMateUsers = amplifyUsers.compactMap {
            AmplifyUserConverter.toBarterMateModel(user: $0.user)
        }
        
        let barterMateItems = amplifyItems.compactMap {
            AmplifyItemConverter.toBarterMateModel(item: $0)
        }
        
        let userLocked = transaction.userLocked ?? []
        
        let hasLockedOffer = userLocked.compactMap {
            if let id = $0?.userId {
                return Identifier<BarterMateUser>(value: id)
            }
            return nil
        }
        
        let userCompleted = transaction.userCompleted ?? []
        
        let hasCompletedBarter = userCompleted.compactMap {
            if let id = $0?.userId {
                return Identifier<BarterMateUser>(value: id)
            }
            return nil
        }
        
        let userSet = Set(barterMateUsers)
        let itemSet = Set(barterMateItems)
        let state = toBarterMateState(status: status)

        
        let barterMateTransaction = BarterMateTransaction(id: Identifier(value: transaction.id),
                                                          participants:
                                                            userSet,
                                                          itemPool: itemSet,
                                                          hasLockedOffer: Set(hasLockedOffer),
                                                          hasCompletedBarter: Set(hasCompletedBarter),
                                                          state: state)
        
        return barterMateTransaction
    }
    
    static func toAmplifyModel(transaction: BarterMateTransaction) -> Transaction {
        
        let id = transaction.id.value
        let status = toAmplifyStatus(state: transaction.state)
        
        let amplifyTransaction = Transaction(id: id,
                                             status: status)
        
        return amplifyTransaction
        
    }
    

    
    static func toBarterMateState(status: TransactionStatus) -> TransactionState {
        switch status {
        case .confirmationPending:
            return .INITIATED
        case .paymentPending:
            return .ITEMLOCKED
        case .completed:
            return .COMPLETED
        }
    }
    
    static func toAmplifyStatus(state: TransactionState) -> TransactionStatus {
        switch state {
        case .INITIATED:
            return .confirmationPending
        case .ITEMLOCKED:
            return .paymentPending
        case .COMPLETED:
            return .completed
        }
    }
}

