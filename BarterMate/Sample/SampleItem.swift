//
//  SampleItem.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import Foundation

struct SampleItem {
    
    static let waterBottle = BarterMateItem(id: Identifier(value: "1234"),
                                            name: "Water Bottle",
                                            description: "500 ml, new",
                                            imageUrl: nil,
                                            ownerId: Identifier(value: "123"),
                                            createdAt: Date(),
                                            updatedAt: Date())
    
    static let guitar = BarterMateItem(id: Identifier(value: "12345"),
                                       name: "guitar",
                                       description: "Ibanez Acoustic Guitar",
                                       imageUrl: nil,
                                       ownerId: Identifier(value: "123"),
                                       createdAt: Date(),
                                       updatedAt: Date())
}
