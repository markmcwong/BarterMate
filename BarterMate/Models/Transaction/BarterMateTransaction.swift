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

class BarterMateTransaction: Hashable, LazyListElement, TransactionFacadeDelegate, ObservableObject {

    var id: Identifier<BarterMateTransaction>
    @Published var participants: (Set<BarterMateUser>)?
    @Published var itemPool: (Set<BarterMateItem>)?
    @Published var hasLockedOffer: Set<Identifier<BarterMateUser>>
    @Published var hasCompletedBarter: Set<Identifier<BarterMateUser>>
    @Published var state: TransactionState
    var fetchParticipantsClosure: ((@escaping (Set<BarterMateUser>) -> Set<BarterMateUser>) -> Void)?
    var fetchItemsClosure: ((@escaping (Set<BarterMateItem>) -> Set<BarterMateItem>) -> Void)?
    var hasFetchedDetails: Bool = false
    
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
         participants: Set<BarterMateUser>,
         itemPool: Set<BarterMateItem>,
         hasLockedOffer: Set<Identifier<BarterMateUser>>,
         hasCompletedBarter: Set<Identifier<BarterMateUser>>,
         fetchParticipantsClosure: ((@escaping (Set<BarterMateUser>) -> Set<BarterMateUser>) -> Void)? = nil,
         fetchItemsClosure: ((@escaping (Set<BarterMateItem>) -> Set<BarterMateItem>) -> Void)? = nil,
         state: TransactionState) {
        self.id = id
        self.participants = participants
        self.itemPool = itemPool
        self.state = state
        self.hasLockedOffer = hasLockedOffer
        self.hasCompletedBarter = hasCompletedBarter
        self.fetchParticipantsClosure = fetchParticipantsClosure
        self.fetchItemsClosure = fetchItemsClosure
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
        guard (participants != nil) && !participants!.contains(user) else {
            return
        }
        facade?.addUser(user: user)
        participants!.insert(user)
    }
    
    func removeUser(user: BarterMateUser) {
        guard state == .INITIATED, var participants = participants else {
            return
        }
        guard participants.contains(user) else {
            return
        }
        facade?.removeUser(user: user)
        participants.remove(user)
    }
    
    func addItem(item: BarterMateItem) {
        guard state == .INITIATED, var itemPool = itemPool else {
            return
        }

        guard !itemPool.contains(item) else {
            return
        }
        facade?.addItem(item: item)
        itemPool.insert(item)
    }
    
    func removeItem(item: BarterMateItem) {
        guard state == .INITIATED, var itemPool = itemPool else {
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
        guard state == .INITIATED, var participants = participants else {
            return
        }
        for participant in participants {
            if !hasLockedOffer.contains(participant.id) {
                return
            }
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
        guard state == .ITEMLOCKED, let participants = participants else {
            return
        }
        for participant in participants {
            if !hasCompletedBarter.contains(participant.id) {
                return
            }
        }
        state = .COMPLETED
        facade?.completeTransaction()
    }
    
    static func == (lhs: BarterMateTransaction, rhs: BarterMateTransaction) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func fetchDetails() {
        fetchParticipants()
        fetchItems()
        self.hasFetchedDetails = true
    }
    
    func fetchParticipants() {
        if self.participants == nil {
            print("inner fetch")
            guard let fetchParticipantsClosure = fetchParticipantsClosure else {
                print("fetch participants closuer wrong")
                self.participants = []
                return
            }
            fetchParticipantsClosure {
                print("fetchParticipantsClosure : ", $0)
                self.participants = $0
                return $0
            }
            return
        }
    }

    func fetchItems() {
        if self.itemPool == nil {
            guard let fetchItemsClosure = fetchItemsClosure else {
                print("fetch user closuer wrong")
                self.itemPool = []
                return
            }
            fetchItemsClosure {
                print("fetchItemsClosure : ", $0)
                self.itemPool = $0
                return $0
            }
            return
        }
    }
    
}


