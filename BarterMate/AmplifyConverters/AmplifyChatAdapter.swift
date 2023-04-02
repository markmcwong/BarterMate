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
        guard let name = chat.name else {
            completion(nil)
            return
        }


        Task {
            try await chat.ChatUsers?.fetch()
            let chatUsers = chat.ChatUsers?.compactMap { chatUser in
                return AmplifyUserConverter.toBarterMateModel(user: chatUser.user)
                // return Identifier<BarterMateUser>(value: user.id)
            }
            
//            try await chat.ChatMessages?.fetch()
//            let chatMessages = chat.ChatMessages?.compactMap { message in
//                return AmplifyMessageAdapter.toBarterMateModel(message: message)
//            }
//            print("Chat Messages: ", chat.ChatMessages?.elements.description)
            
            let task  = {
                do {
                    try await chat.ChatMessages!.fetch()
                    //                    chat.ChatMessages?.
                    //                    let chatMessages = chat.ChatMessages?.compactMap { chatMessage in
                    //                        return AmplifyMessageAdapter.toBarterMateModel(message: chatMessage)
                    //                    }
                    //                    barterMateChat.messages = chatMessages!
                } catch let error {
                    print("Barter Mate Chat error: ", error.localizedDescription)
                    //                                barterMateChat.messages = []
                }
            }
            

            let barterMateChat = BarterMateChat(id: Identifier(value: chat.id),
                                      name: name,
                                      messages: [], // chatMessages,
                                      users: chatUsers!,
                                      fetchMessagesClosure: task
                                 )
            
//            barterMateChat.setFetchMessages {
//                do {
//                    print(chat.ChatMessages)
//                    try await chat.ChatMessages!.fetch()
//                    print(chat.ChatMessages)
////                    chat.ChatMessages?.
////                    let chatMessages = chat.ChatMessages?.compactMap { chatMessage in
////                        return AmplifyMessageAdapter.toBarterMateModel(message: chatMessage)
////                    }
////                    barterMateChat.messages = chatMessages!
//                } catch let error {
//                    print("Barter Mate Chat error: ", error.localizedDescription)
//                    barterMateChat.messages = []
//                }
//
//            }
//
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
        let amplifyUser = AmplifyUserConverter.toAmplifyModel(user: user)
        let amplifyUserChat = UserChat(id: id.value,
                                       chat: amplifyChat,
                                       user: amplifyUser)
        return amplifyUserChat
    }
}
