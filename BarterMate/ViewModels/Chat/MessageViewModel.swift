//
//  MessageListViewModel.swift
//  BarterMate
//
//  Created by mark on 2/4/2023.
//

import Foundation
import Combine

class MessageViewModel: ObservableObject {
    private let chat: BarterMateChat
    @Published var messageProvider: AmplifySubscriptionProvider<BarterMateMessage>
    @Published var chatName: String
    @Published var chatId: String

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
        let newMessage = BarterMateMessage(id: Identifier(value: UUID().uuidString),
                                           sentIn: chat,
                                           sentBy: GlobalState.shared.user!,
                                           fetchUserClosure: nil,
                                           createdAt: .now,
                                           content: text)
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
