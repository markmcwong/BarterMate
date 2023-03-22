//
//  Chat+Extension.swift
//  BarterMate
//
//  Created by mark on 22/3/2023.
//

import Foundation

extension Chat: BarterMateModel {
    static func getModelKey(input: String) -> CodingKeys? {
        return Chat.keys.init(rawValue: input)
    }
     
    typealias t = CodingKeys
}
