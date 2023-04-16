//
//  TransactionListViewModel.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

import Foundation
import Combine

class TransactionListViewModel: ListViewModel<BarterMateTransaction> {
    @Published var userList: ModelList<BarterMateUser>
    private var cancellables = [AnyCancellable]()

    init(transactions: ModelList<BarterMateTransaction>, user: BarterMateUser) {
        self.userList = ModelList<BarterMateUser>.all()
        super.init(user: user, modelList: transactions)
        modelList.objectWillChange.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }

    func refresh() {
        guard let user = user else {
            return
        }
        self.modelList = TransactionList.transactions_of(user.id)
        modelList.objectWillChange.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
}
