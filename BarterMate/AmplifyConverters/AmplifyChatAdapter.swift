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
    static func toBarterMateModel(chat: Chat) -> BarterMateChat {

//        Task {
//            try await chat.ChatUsers?.fetch()
//            do {
//                try await chat.ChatMessages?.fetch()
//            } catch let error as DataStoreError {
//                print("DataStoreError: ", error.recoverySuggestion)
//                //                                barterMateChat.messages = []
//            } catch let error as CoreError {
//                print("CoreError: ", error.recoverySuggestion)
//                print(error.debugDescription, error.localizedDescription)
//                //                                barterMateChat.messages = []
//            } catch let error {
//                print("Barter Mate Chat Message error: ", error.localizedDescription)
//                //                                barterMateChat.messages = []
//            }
            
//            try await chat.ChatMessages?.fetch()
//            let chatMessages = chat.ChatMessages?.compactMap { message in
//                return AmplifyMessageAdapter.toBarterMateModel(message: message)
//            }
//            print("Chat Messages: ", chat.ChatMessages?.elements.description)
            
            let BarterMateUserTask: () async -> [BarterMateUser] = {
                do {
                    try await chat.ChatUsers!.fetch()
                    let chatUsersList: List<UserChat> = chat.ChatUsers!
                    let group = DispatchGroup()
                    var chatUserResults: [BarterMateUser] = []
                    for chatUser in chatUsersList {
                        Future(asyncFunc: {
                            group.enter()
                            let amplifiedUser: User = try await chatUser._user.get() ?? User(id: "404", username: "User not Found")
                            let barterMateUser: BarterMateUser = AmplifyUserConverter.toBarterMateModel(user: amplifiedUser)!
                            chatUserResults.append(barterMateUser)
                            group.leave()
                        })
                    }
                    //                    let chatUsers: [Future<BarterMateUser, Never>] = chatUsersList.map { chatUser in
                    //                        return Future(asyncFunc: {
                    //                            group.enter()
                    //                            let amplifiedUser: User = try await chatUser._user.get() ?? User(id: "404", username: "User not Found")
                    //                            group.leave()
                    //                            return AmplifyUserConverter.toBarterMateModel(user: amplifiedUser)!
                    //                        })
                    //                    }
                    return chatUserResults
                } catch {
                    return []
                }
            }
//        let BarterMateMessageTask: (() async -> [BarterMateMessage])? =
        func BarterMateMessageTask (completion: @escaping ([BarterMateMessage]) -> Void) -> Void {
//        func BarterMateMessageTask (completion: @escaping ([BarterMateMessage]) -> Void) {
            Task {
                try await chat.ChatMessages!.fetch()
                let chatMessagesList: List<Message> = chat.ChatMessages!
                let group = DispatchGroup()
                var chatMessageResults: [BarterMateMessage] = []
                for chatMessage in chatMessagesList {
                    Future(asyncFunc: {
                        group.enter()
                        let barterMateMessage: BarterMateMessage = AmplifyMessageAdapter.toBarterMateModel(message: chatMessage)
                        chatMessageResults.append(barterMateMessage)
                        group.leave()
                    })
                }
                group.notify(queue: DispatchQueue.main) {
                       completion (chatMessageResults)
                }
            }
        }
        
            let barterMateChat = BarterMateChat(
                id: Identifier(value: chat.id),
                                name: chat.name,
                                messages: [],
                                users: [],
                                fetchMessagesClosure: BarterMateMessageTask,
                                fetchUsersClosure: BarterMateUserTask
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
//            completion(barterMateChat)
            return barterMateChat
    }
    
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
