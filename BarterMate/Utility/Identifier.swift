//
//  Identifier.swift
//  BarterMate
//
//  Created by Zico on 24/3/23.
//

struct Identifier<Type>: Hashable {
    let value: String
}

extension Identifier: Equatable {
    static func == (lhs: Identifier, rhs: Identifier) -> Bool {
        lhs.value == rhs.value
    }
}
