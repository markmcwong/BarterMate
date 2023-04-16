//
//  ChatListViewModel.swift
//  BarterMate
//
//  Created by mark on 2/4/2023.
//

import Foundation
import Combine

class ChatListViewModel: ListViewModel<BarterMateChat> {
    var chatService: ChatService
    
    init() {
        self.chatService = AmplifyChatService()
        super.init(user: nil, modelList: ModelList<BarterMateChat>.empty())
        self.fetchChatUserBelongsTo()
    }
    
    func fetchChatUserBelongsTo() {
        DispatchQueue.main.async {
            Task {
                let items = await self.chatService.getCurrentUserChats(id: GlobalState.shared.userId!)
                self.modelList.insertAll(models: items)
                print(items)
                self.objectWillChange.send()
            }
        }
    }
}
