//
//  BarterMateList.swift
//  BarterMate
//
//  Created by Zico on 7/4/23.
//

import Combine

class TransactionList: ModelList<BarterMateTransaction> {
    private var modelListFacade: (any ModelListFacade)?

    override private init() {
        super.init()
    }

    override func setFacade() {
        self.modelListFacade = AmplifyTransactionListFacade()
    }

    static func transactions_of(_ ownerId: Identifier<BarterMateUser>) -> TransactionList {
        print("called for TransactionList")
        let modelList = TransactionList()
        modelList.setFacade()
        modelList.modelListFacade?.setDelegate(delegate: modelList)
        modelList.modelListFacade?.getModelsById(of: ownerId)
        return modelList
    }

    func insert(transaction: BarterMateTransaction) {
        self.elements.append(transaction)
    }

    func remove(transaction: BarterMateTransaction) {
        if let index = self.elements.firstIndex(of: transaction) {
            self.elements.remove(at: index)
        }
    }

    func insertAll(transactions: [BarterMateTransaction]) {
        self.elements.append(contentsOf: transactions)
    }
}
