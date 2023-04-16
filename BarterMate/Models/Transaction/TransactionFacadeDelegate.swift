//
//  TransactionFacadeDelegate.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

protocol TransactionFacadeDelegate {
    var id: Identifier<BarterMateTransaction> { get }
}
