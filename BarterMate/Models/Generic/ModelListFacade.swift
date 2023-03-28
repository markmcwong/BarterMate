//
//  ListFacade.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

protocol ModelListFacade {
    associatedtype Model
    var delegate: ItemListFacadeDelegate? { get set }
    func save(model: Model)
    func delete(model: Model)
    func getItemsById(of user: Identifier<User>)
}
