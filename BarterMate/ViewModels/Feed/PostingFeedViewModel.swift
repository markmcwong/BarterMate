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
