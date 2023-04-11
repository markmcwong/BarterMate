//
//  TransactionFacade.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

protocol TransactionFacade {
    func setDelegate(delegate: TransactionFacadeDelegate)
    func createTransaction(transaction: BarterMateTransaction)
    func addUser(user: BarterMateUser)
    func removeUser(user: BarterMateUser)
    func addItem(item: BarterMateItem)
    func removeItem(item: BarterMateItem)
    func userLockTransaction(user: BarterMateUser)
    func userCompleteBarter(user: BarterMateUser)
    func lockTransaction()
    func completeTransaction()
}

