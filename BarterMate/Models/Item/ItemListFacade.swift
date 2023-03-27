//
//  ItemListFacade.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

protocol ItemListFacade {
    var delegate: ItemListFacadeDelegate? { get set }
    func save(item: BarterMateItem)
    func delete(item: BarterMateItem)
    func getItemsById(of user: Identifier<User>)
}
