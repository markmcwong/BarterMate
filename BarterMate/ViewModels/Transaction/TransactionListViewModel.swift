//
//  TransactionListViewModel.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

import Foundation
import Combine

class TransactionListViewModel: ObservableObject {
    @Published var transactions: TransactionList
    @Published var userList: ModelList<BarterMateUser>
    var user: BarterMateUser
    private var cancellables = [AnyCancellable]()
    
    init(transactions: TransactionList, user: BarterMateUser) {
        self.user = user
        self.userList = ModelList<BarterMateUser>.all()
        self.transactions = transactions
        transactions.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
    
    func refresh() {
        self.transactions = TransactionList.of(userId: user.id)
        transactions.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
}

