//
//  BarterMateUser.swift
//  BarterMate
//
//  Created by Zico on 24/3/23.
//

class BarterMateUser {
    let id: Identifier<User>
    var username: String
    var items: [Item]?
    var transactions: [UserTransaction]?
    var postings: [Posting]?
    var requests: [Request]?
    
    init(id: Identifier<User>, username: String, items: [Item]?, transactions: [UserTransaction]?, postings: [Posting]?, requests: [Request]?) {
        self.id = id
        self.username = username
        self.items = items
        self.transactions = transactions
        self.postings = postings
        self.requests = requests
    }
    
}
