//
//  MessageListViewModel.swift
//  BarterMate
//
//  Created by mark on 2/4/2023.
//

import Foundation
import Combine

//class MessageListViewModel: BaseViewModel<BarterMateMessage> {
//    override func getUserIdFromModel(_ model: BarterMateMessage) -> Identifier<BarterMateUser>? {
//        return model.sentBy?.id
//    }
//}

class MessageViewModel: ObservableObject {
    private let chat: BarterMateChat
    let messageProvider: AmplifySubscriptionProvider<BarterMateMessage>
    let chatName: String
    let chatId: String
    
    init(chat: BarterMateChat?) {
        guard let chat = chat else {
            fatalError("Chat cannot be nil")
        }
        self.chat = chat
        self.messageProvider = AmplifySubscriptionProvider<BarterMateMessage>()
        self.chatName = chat.name ?? "Default Chat Name"
        self.chatId = chat.id.value
    }
        
    
    func sendMessage(_ text: String) {
        let newMessage = BarterMateMessage(id: Identifier(value: UUID().uuidString), sentIn: chat, sentBy: GlobalState.shared.user!, fetchUserClosure: nil, createdAt: .now, content: text)
        messageProvider.save(newMessage) { result in
            switch result {
            case .success:
                print("Message saved successfully")
            case .failure(let error):
                print("Failed to save message with error: \(error)")
            }
        }
    }
}
