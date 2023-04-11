//
//  SampleTransaction.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

import Foundation

struct SampleTransaction {
    static let sampleTransaction = BarterMateTransaction(participants: Set([SampleUser.bill, SampleUser.bob]),
                                                         itemPool: Set([SampleItem.guitar, SampleItem.waterBottle]),
                                                         hasLockedOffer: Set([SampleUser.bill.id]),
                                                         hasCompletedBarter: Set([]),
                                                         state: .INITIATED)
}

