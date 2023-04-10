//
//  BarterMateTransaction.swift
//  BarterMate
//
//  Created by Zico on 7/4/23.
//

import Foundation

enum TransactionState: String {
    case INITIATED = "Initiated"
    case ITEMLOCKED = "Item Locked"
    case COMPLETED = "Barter Completed"
}

class BarterMateTransaction: Hashable, ListElement, TransactionFacadeDelegate, ObservableObject {

    var id: Identifier<BarterMateTransaction>
    @Published var participants: Set<BarterMateUser>
    @Published var itemPool: Set<BarterMateItem>
    @Published var hasLockedOffer: Set<BarterMateUser>
    @Published var hasCompletedBarter: Set<BarterMateUser>
    @Published var state: TransactionState
    
    var facade: TransactionFacade?
    
    init(id: Identifier<BarterMateTransaction> = Identifier(value: UUID().uuidString),
         participants: Set<BarterMateUser>,
         itemPool: Set<BarterMateItem>,
         hasLockedOffer: Set<BarterMateUser>,
         hasCompletedBarter: Set<BarterMateUser>,
         state: TransactionState) {
        self.id = id
        self.participants = participants
        self.itemPool = itemPool
        self.state = state
        self.hasLockedOffer = hasLockedOffer
        self.hasCompletedBarter = hasCompletedBarter
        setUpFacade()
    }
    
    func setUpFacade() {
        self.facade = AmplifyTransactionFacade()
        self.facade?.setDelegate(delegate: self)
    }
    
    func addUser(user: BarterMateUser) {
        guard !participants.contains(user) else {
            return
        }
        facade?.addUser(user: user)
        participants.insert(user)
    }
    
    func removeUser(user: BarterMateUser) {
        guard participants.contains(user) else {
            return
        }
        facade?.removeUser(user: user)
        participants.remove(user)
    }
    
    func addItem(item: BarterMateItem) {
        guard !itemPool.contains(item) else {
            return
        }
        facade?.addItem(item: item)
        itemPool.insert(item)
    }
    
    func removeItem(item: BarterMateItem) {
        guard itemPool.contains(item) else {
            return
        }
        facade?.removeItem(item: item)
        itemPool.remove(item)
    }
    
    func userLockTransaction(user: BarterMateUser) {
        guard state == .INITIATED else {
            return
        }
        
        hasLockedOffer.insert(user)
        facade?.userLockTransaction(user: user)
    }
    
    func lockTransaction() {
        state = .ITEMLOCKED
        facade?.lockTransaction()
    }
    
    static func == (lhs: BarterMateTransaction, rhs: BarterMateTransaction) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

