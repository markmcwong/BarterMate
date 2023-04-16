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
    @Published var hasLockedOffer: Set<Identifier<BarterMateUser>>
    @Published var hasCompletedBarter: Set<Identifier<BarterMateUser>>
    @Published var state: TransactionState

    var facade: TransactionFacade?

    static func createNewTransaction() -> BarterMateTransaction {
        let transaction = BarterMateTransaction(participants: [],
                                                itemPool: [],
                                                hasLockedOffer: [],
                                                hasCompletedBarter: [],
                                                state: .INITIATED)
        transaction.facade?.createTransaction(transaction: transaction)
        return transaction
    }

    init(id: Identifier<BarterMateTransaction> = Identifier(value: UUID().uuidString),
         participants: (Set<BarterMateUser>),
         itemPool: (Set<BarterMateItem>),
         hasLockedOffer: Set<Identifier<BarterMateUser>>,
         hasCompletedBarter: Set<Identifier<BarterMateUser>>,
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
        guard state == .INITIATED else {
            return
        }
        guard !participants.contains(user) else {
            return
        }
        facade?.addUser(user: user)
        participants.insert(user)
    }

    func removeUser(user: BarterMateUser) {
        guard state == .INITIATED else {
            return
        }
        guard participants.contains(user) else {
            return
        }
        facade?.removeUser(user: user)
        participants.remove(user)
    }

    func addItem(item: BarterMateItem) {
        guard state == .INITIATED else {
            return
        }

        guard !itemPool.contains(item) else {
            return
        }
        facade?.addItem(item: item)
        itemPool.insert(item)
    }

    func removeItem(item: BarterMateItem) {
        guard state == .INITIATED else {
            return
        }
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

        hasLockedOffer.insert(user.id)
        facade?.userLockTransaction(user: user)
        lockTransaction()
    }

    func lockTransaction() {
        guard state == .INITIATED else {
            return
        }
        for participant in participants where !hasLockedOffer.contains(participant.id) {
            return
        }
        state = .ITEMLOCKED
        facade?.lockTransaction()
    }

    func userCompleteBarter(user: BarterMateUser) {
        guard state == .ITEMLOCKED else {
            return
        }

        hasCompletedBarter.insert(user.id)
        facade?.userCompleteBarter(user: user)
        completeBarter()
    }

    func completeBarter() {
        guard state == .ITEMLOCKED else {
            return
        }
        for participant in participants where !hasCompletedBarter.contains(participant.id) {
            return
        }
        state = .COMPLETED
        facade?.completeTransaction()
    }

    static func == (lhs: BarterMateTransaction, rhs: BarterMateTransaction) -> Bool {
        lhs.id == rhs.id && lhs.participants == rhs.participants && lhs.itemPool == rhs.itemPool
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(itemPool)
        hasher.combine(participants)
    }
}
