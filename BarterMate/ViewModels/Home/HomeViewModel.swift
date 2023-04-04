//
//  HomeViewModel.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    let user: BarterMateUser
    let requestFeedViewModel: RequestFeedViewModel
    let postingFeedViewModel: PostingFeedViewModel
//    let itemList: ModelList<BarterMateItem>
//    let postingList: ModelList<BarterMatePosting>
//    let requestList: ModelList<BarterMateRequest>
    
    init(user: BarterMateUser) {
        self.user = user
        self.postingFeedViewModel = PostingFeedViewModel(modelType: BarterMatePosting.self)
        self.requestFeedViewModel = RequestFeedViewModel(modelType: BarterMateRequest.self)
    }
}
