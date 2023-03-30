//
//  SampleItem.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import Foundation

struct SampleItem {
    
    static let waterBottle = BarterMateItem(id: Identifier(value: "Bottle"),
                                            name: "Bottle",
                                            description: "500 ml, new",
                                            imageUrl: nil,
                                            ownerId: Identifier(value: "1111"),
                                            createdAt: Date(),
                                            updatedAt: Date())
    
    static let guitar = BarterMateItem(id: Identifier(value: "12345"),
                                       name: "guitar",
                                       description: "Ibanez Acoustic Guitar",
                                       imageUrl: nil,
                                       ownerId: Identifier(value: "7358f9a3-a1d2-44e5-8c64-689f1cf4d646"),
                                       createdAt: Date(),
                                       updatedAt: Date())
}
