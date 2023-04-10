//
//  BarterMateModel.swift
//  BarterMate
//
//  Created by Zico on 29/3/23.
//

import Foundation

protocol ListElement: Hashable, NameDescribable {
    associatedtype U
    var id: Identifier<U> { get }
}

protocol LazyListElement: ListElement {
    associatedtype U
    func fetch(closure: (() async -> [U])) -> [U]
}
