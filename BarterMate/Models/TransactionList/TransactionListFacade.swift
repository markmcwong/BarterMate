//
//  BarterMateListFacade.swift
//  BarterMate
//
//  Created by Zico on 7/4/23.
//

protocol TransactionListFacade {
    func setDelegate(delegate: any TransactionListFacadeDelegate)
    func save(model: BarterMateTransaction)
    func delete(model: BarterMateTransaction)
    func getModelsWithUser(of userId: Identifier<BarterMateUser>)
    func getAll()
}


