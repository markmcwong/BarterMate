//
//  PostingFeedViewModel.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import Foundation
import Combine

class PostingFeedViewModel: BaseViewModel<BarterMatePosting> {
    override func getUserIdFromModel(_ model: BarterMatePosting) -> Identifier<BarterMateUser> {
        model.item.ownerId
    }
}

// class PostingFeedViewModel: ObservableObject {
//    @Published var postingList: ModelList<BarterMatePosting>
//    var userIds: [Identifier<BarterMateUser>] = []
//    @Published var userIdToUser: [Identifier<BarterMateUser> : BarterMateUser] = [:]
//    private var cancellables: Set<AnyCancellable> = []
//
//    init() {
//        self.postingList = ModelList<BarterMatePosting>.all()
//        postingList.objectWillChange.receive(on: DispatchQueue.main).sink {
//            [weak self] _ in
//            self?.objectWillChange.send()
//            self?.populateUserMap()
//        }.store(in: &cancellables)
//    }
//
//    private func populateUserMap() {
//        for posting in postingList.elements {
//            let userId = posting.item.ownerId
//            if userIds.contains(userId) {
//                continue
//            }
//            let user = BarterMateUser.getUserWithId(id: userId)
//            userIdToUser[userId] = user
//        }
//    }
// }
