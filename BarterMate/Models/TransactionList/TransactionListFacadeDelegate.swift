//
//  BarterMateListFacadeDelegate.swift
//  BarterMate
//
//  Created by Zico on 7/4/23.
//

import Foundation

protocol TransactionListFacadeDelegate {
    func insert(transaction: BarterMateTransaction)
    func insertAll(transactions: [BarterMateTransaction])
    func remove(transaction: BarterMateTransaction)
}

