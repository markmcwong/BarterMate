//
//  BarterMateUser.swift
//  BarterMate
//
//  Created by Zico on 24/3/23.
//

class BarterMateUser {
    let id: Identifier<User>
    var username: String
//    var items: [BarterMateItem]?
//    var transactions: [Transaction]?
//    var postings: [BarterMatePosting]?
//    var requests: [BarterMateRequest]?
    
//    init(id: Identifier<User>, username: String, items: [BarterMateItem]?, transactions: [Transaction]?, postings: [BarterMatePosting]?, requests: [BarterMateRequest]?) {
//        self.id = id
//        self.username = username
//        self.items = items
//        self.transactions = transactions
//        self.postings = postings
//        self.requests = requests
//    }
    
    init(id: Identifier<User>, username: String) {
        self.id = id
        self.username = username
    }
    
}
