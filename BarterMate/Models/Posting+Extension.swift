//
//  Posting.swift
//  BarterMate
//
//  Created by mark on 22/3/2023.
//

import Foundation

extension Posting: BarterMateModel {
    static func getModelKey(input: String) -> CodingKeys? {
        return Posting.keys.init(rawValue: input)
    }
     
    typealias key = CodingKeys
}
