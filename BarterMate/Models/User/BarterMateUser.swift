//
//  BarterMateUser.swift
//  BarterMate
//
//  Created by Zico on 24/3/23.
//

import Foundation

class BarterMateUser: ObservableObject {
    var id: Identifier<BarterMateUser>
    var username: String
    
    private var userFacade: (any UserFacade)?
//    @Published var items: ModelList<BarterMateItem>
//    @Published var transactions: [Transaction]
//    @Published var postings: ModelList<BarterMatePosting>
//    @Published var requests: ModelList<BarterMateRequest>
    
    static func getUserWithId(id: Identifier<BarterMateUser>) -> BarterMateUser {
        let user = createEmptyUser()
        let facade = AmplifyUserFacade()
        user.userFacade = facade
        facade.delegate = user
        user.userFacade?.getUserById(id: id)
        return user
    }
    
    static func createEmptyUser() -> BarterMateUser {
        BarterMateUser(id: Identifier(value: ""), username: "")
    }
    
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

extension BarterMateUser: UserFacadeDelegate {
    func update(user: BarterMateUser) {
        self.id = user.id
        self.username = user.username
    }
}
