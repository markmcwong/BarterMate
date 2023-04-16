//
//  ChatService.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

import Foundation
import Amplify

protocol ChatService {
    func getCurrentUserChats(id: String) async -> [BarterMateChat]
    func insertUserChats(userChats: [UserChat])
}
