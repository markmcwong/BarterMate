//
//  AmplifyChatAdapter.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Amplify
import Foundation
import Combine

struct AmplifyChatAdapter {
    static func toBarterMateModel(chat: Chat, completion: @escaping (BarterMateChat?) -> Void) {
        guard let name = chat.name,
              let messages = chat.ChatMessages
          else {
            completion(nil)
            return
        }

//        let chatMessages = messages.compactMap { message in
//            return AmplifyMessageAdapter.toBarterMateModel(message: message)
//        }
        Task {
            try await chat.ChatUsers?.fetch()
            let chatUsers = chat.ChatUsers?.compactMap { chatUser in
                return AmplifyUserAdapter.toBarterMateModel(user: chatUser.user)
            }
//            let chatUsers = chat.ChatUsers?.compactMap { user in
//                return Identifier<BarterMateUser>(value: user.id)
//            }

            let barterMateChat = BarterMateChat(id: Identifier(value: chat.id),
                                      name: name,
                                      messages: [],
                                      users: chatUsers!)
            completion(barterMateChat)
        }
    }
//
    static func toAmplifyModel(chat: BarterMateChat) -> Chat {
        let amplifyChatMessages: List<Message> = List(elements: chat.messages.map { message in
            return AmplifyMessageAdapter.toAmplifyModel(message: message)
        })
        
//        let chatUsers: List<UserChat> = List(elements: chat.users.compactMap { user in
//            return AmplifyUserChatAdapter.toAmplifyModel(user: user, chat: chat, id: chat.id)
//        })
        
        let amplifyChat = Chat(id: chat.id.value,
                               ChatMessages: amplifyChatMessages, ChatUsers: [], name: chat.name)
        
        return amplifyChat
    }
    
}

struct AmplifyUserChatAdapter {
    static func toAmplifyModel(user: BarterMateUser, chat: BarterMateChat, id: Identifier<Chat>) -> UserChat {
        let amplifyChat = AmplifyChatAdapter.toAmplifyModel(chat: chat)
        let amplifyUser = AmplifyUserAdapter.toAmplifyModel(user: user)
        let amplifyUserChat = UserChat(id: id.value,
                                       chat: amplifyChat,
                                       user: amplifyUser)
        return amplifyUserChat
    }
}
