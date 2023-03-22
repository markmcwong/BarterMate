//
//  User+Extension.swift
//  BarterMate
//
//  Created by mark on 22/3/2023.
//

import Foundation

extension User: BarterMateModel {
    static func getModelKey(input: String) -> CodingKeys? {
        return User.keys.init(rawValue: input)
    }
     
    typealias key = CodingKeys
}
