//
//  TransactionListViewModel.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

import Foundation
import Combine

class TransactionListViewModel: ListViewModel<BarterMateTransaction> {
//    @Published var transactions: TransactionList
//    @Published var transactions: ModelList<BarterMateTransaction>
    @Published var userList: ModelList<BarterMateUser>
//    var user: BarterMateUser
    private var cancellables = [AnyCancellable]()
    
    init(transactions: ModelList<BarterMateTransaction>, user: BarterMateUser) {
        self.userList = ModelList<BarterMateUser>.all()
        super.init(user: user, modelList: transactions)
        modelList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
}

