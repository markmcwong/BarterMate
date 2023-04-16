//
//  HomeViewModel.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published private(set) var user: BarterMateUser
    let requestFeedViewModel: RequestFeedViewModel
    let postingFeedViewModel: PostingFeedViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(user: BarterMateUser) {
        self.user = user
        self.postingFeedViewModel = PostingFeedViewModel(modelType: BarterMatePosting.self)
        self.requestFeedViewModel = RequestFeedViewModel(modelType: BarterMateRequest.self)
        user.objectWillChange.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
}
