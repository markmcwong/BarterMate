//
//  BarterMateUser.swift
//  BarterMate
//
//  Created by Zico on 24/3/23.
//

import Foundation

class BarterMateUser: ObservableObject {
    let id: Identifier<BarterMateUser>
    var username: String
//    @Published var items: ModelList<BarterMateItem>
//    @Published var transactions: [Transaction]
//    @Published var postings: ModelList<BarterMatePosting>
//    @Published var requests: ModelList<BarterMateRequest>
    
//    init(id: Identifier<User>, username: String, items: [BarterMateItem]?, transactions: [Transaction]?, postings: [BarterMatePosting]?, requests: [BarterMateRequest]?) {
//        self.id = id
//        self.username = username
//        self.items = items
//        self.transactions = transactions
//        self.postings = postings
//        self.requests = requests
//    }
    
    init(id: Identifier<BarterMateUser> = Identifier(value: UUID().uuidString), username: String) {
        self.id = id
        self.username = username
//        items = ModelList<BarterMateItem>.empty()
//        postings = ModelList<BarterMatePosting>.empty()
//        transactions = []
//        requests = ModelList<BarterMateRequest>.empty()
    }
    
//    func loadPostings() {
//        postings = ModelList<BarterMatePosting>.of(self.id)
//    }
//
//    func loadItems() {
//        items = ModelList<BarterMateItem>.of(self.id)
//    }
//
//    func loadRequests() {
//        requests = ModelList<BarterMateRequest>.of(self.id)
//    }
//
//    func loadData() {
//        loadItems()
//        loadPostings()
//        loadRequests()
//    }
    
}
