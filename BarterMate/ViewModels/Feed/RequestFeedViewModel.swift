//
//  RequestFeedViewModel.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import Foundation
import Combine

class RequestFeedViewModel: BaseViewModel<BarterMateRequest> {
    override func getUserIdFromModel(_ model: BarterMateRequest) -> Identifier<BarterMateUser> {
        return model.ownerId
    }
}

//class RequestFeedViewModel: ObservableObject {
//    @Published var requestList: ModelList<BarterMateRequest>
//    var userIds: [Identifier<BarterMateUser>] = []
//    @Published var userIdToUser: [Identifier<BarterMateUser> : BarterMateUser] = [:]
//    private var cancellables: Set<AnyCancellable> = []
//
//    init() {
//        self.requestList = ModelList<BarterMateRequest>.all()
//        requestList.objectWillChange.receive(on: DispatchQueue.main).sink {
//            [weak self] _ in
//            self?.objectWillChange.send()
//            self?.populateUserMap()
//        }.store(in: &cancellables)
//    }
//
//    private func populateUserMap() {
//        for request in requestList.elements {
//            let userId = request.ownerId
//            if userIds.contains(userId) {
//                continue
//            }
//            let user = BarterMateUser.getUserWithId(id: userId)
//            userIdToUser[userId] = user
//        }
//    }
//}
