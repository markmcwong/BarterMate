//
//  MessageListViewModel.swift
//  BarterMate
//
//  Created by mark on 2/4/2023.
//

import Foundation
import Combine

class MessageListViewModel: BaseViewModel<BarterMateMessage> {
    override func getUserIdFromModel(_ model: BarterMateMessage) -> Identifier<BarterMateUser>? {
        return model.sentBy?.id
    }
}
