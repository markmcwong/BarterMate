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
        model.ownerId
    }
}
