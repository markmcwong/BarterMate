//
//  AmplifyChatAdapter.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Amplify
import Foundation

struct AmplifyChatAdapter {
    
    static func toBarterMateModel(chat: Chat) -> BarterMateChat? {
        guard let name = chat.name,
              let createdAt = chat.createdAt,
              let updatedAt = chat.updatedAt else {
            return nil
        }
        
        let chatMessages = chat.ChatMessages?.compactMap { message in
            return AmplifyMessageAdapter.toBarterMateModel(message: message)
        }
        
        let chatUsers = chat.ChatUsers?.compactMap { user in
            return AmplifyUserAdapter.toBarterMateModel(user: user.user)
        }
        
        let barterMateChat = BarterMateChat(id: Identifier(value: chat.id),
                                  name: name,
                                  messages: chatMessages ?? [],
                                  users: chatUsers ?? [])
        
        return barterMateChat
    }
    
    static func toAmplifyModel(chat: BarterMateChat) -> Chat {
        let amplifyChatMessages: List<Message> = List(elements: chat.messages.map { message in
            return AmplifyMessageAdapter.toAmplifyModel(message: message)
        })
        
        let chatUsers: List<UserChat> = List(elements: chat.users.compactMap { user in
            return AmplifyUserChatAdapter.toAmplifyModel(user: user, chat: chat, id: chat.id)
        })
        
        let amplifyChat = Chat(id: chat.id.value,
                               ChatMessages: amplifyChatMessages, ChatUsers: chatUsers, name: chat.name)
        
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
