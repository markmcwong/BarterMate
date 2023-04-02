//
//  ChatListViewModel.swift
//  BarterMate
//
//  Created by mark on 2/4/2023.
//

import Foundation
import Combine

class ChatListViewModel: ObservableObject {
    @Published var chatList: ModelList<BarterMateChat>
    @Published var userMap: [Identifier<BarterMateUser>: BarterMateUser] = [:]
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.chatList = ModelList<BarterMateChat>.all()
        chatList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
            self?.populateUserMap()
        }.store(in: &cancellables)
    }
    
    private func populateUserMap() {
        for chat in chatList.elements {
            for user in chat.users {
                let userId = user.id
                if userMap.keys.contains(userId) {
                    continue
                }
                let barterMateUser = BarterMateUser.getUserWithId(id: userId)
                userMap[userId] = barterMateUser
            }
        }
    }
}
