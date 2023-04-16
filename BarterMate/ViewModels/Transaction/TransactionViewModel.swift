//
//  TransactionViewModel.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

import Foundation
import Combine

class TransactionViewModel: ObservableObject {
    var user: BarterMateUser
    @Published var transaction: BarterMateTransaction
    @Published var userToItemsMap: [Identifier<BarterMateUser>: [BarterMateItem]] = [:]

    init(user: BarterMateUser, transaction: BarterMateTransaction) {
        self.user = user
        self.transaction = transaction
        populateMap()
    }

    func addItem(item: BarterMateItem) {
        transaction.addItem(item: item)
        userToItemsMap[item.ownerId]?.append(item)
    }

    func removeItem(item: BarterMateItem) {
        transaction.removeItem(item: item)

        guard var userItems = userToItemsMap[item.ownerId] else {
            return
        }

        guard let index = userItems.firstIndex(of: item) else {
            return
        }
        userItems.remove(at: index)
        userToItemsMap[item.ownerId] = userItems
    }

    func lockItem() {
        transaction.userLockTransaction(user: user)
        self.objectWillChange.send()
    }

    func completeBarter() {
        transaction.userCompleteBarter(user: user)
        self.objectWillChange.send()
    }

    private func populateMap() {
        initiateMap()
        for item in transaction.itemPool {
            userToItemsMap[item.ownerId]?.append(item)
        }
    }

    private func initiateMap() {
        for user in transaction.participants {
            userToItemsMap[user.id] = []
        }
    }

    func update() {
        userToItemsMap = [:]
        populateMap()
    }

}
