//
//  SamplePosting.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//

import Foundation

struct SamplePosting {
    static let defaultCreatedAt = { () -> Date in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let createdAt = formatter.date(from: "2022/12/12 12:10") else {
            return Date.now
        }
        return createdAt
    }()
    
    static let defaultUpdatedAt = { () -> Date in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let updatedAt = formatter.date(from: "2022/12/20 12:10") else {
            return Date.now
        }
        return updatedAt
    }()
    
    static let guitarPosting = BarterMatePosting(id: Identifier(value: "guitar"),
                                                 item: SampleItem.guitar,
                                                 createdAt: defaultCreatedAt,
                                                 updatedAt: defaultUpdatedAt)
    
    static let bottlePosting = BarterMatePosting(id: Identifier(value: "Bottle"), item: SampleItem.waterBottle,
    createdAt: defaultCreatedAt,
    updatedAt: defaultUpdatedAt)
}
