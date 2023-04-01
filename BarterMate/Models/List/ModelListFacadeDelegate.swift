//
//  ListFacadeDelegate.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import Foundation

protocol ModelListFacadeDelegate {
    associatedtype Model
    func insert(model: Model)
    func insertAll(models: [Model])
    func remove(model: Model)
}
