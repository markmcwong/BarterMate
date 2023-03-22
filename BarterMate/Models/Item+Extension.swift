//
//  Item.swift
//  BarterMate
//
//  Created by mark on 22/3/2023.
//

import Foundation

extension Item: BarterMateModel {
    static func getModelKey(input: String) -> CodingKeys? {
        return Item.keys.init(rawValue: input)
    }
     
    typealias key = CodingKeys
}
