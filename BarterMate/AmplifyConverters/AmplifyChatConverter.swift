//
//  AmplifyChatAdapter.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Amplify
import Foundation
import Combine

struct AmplifyChatConverter {
    static func toBarterMateModel(chat: Chat) -> BarterMateChat {
        func barterMateUserTask (completion: @escaping ([BarterMateUser]) -> [BarterMateUser]) {
                do {
                    Task {
                        try await chat.ChatUsers!.fetch()
                        let chatUsersList: List<UserChat> = chat.ChatUsers!
                        let group = DispatchGroup()
                        var chatUserResults: [BarterMateUser] = []
                        for chatUser in chatUsersList {
                            group.enter()
                            let amplifiedUser: User = await chatUser.user
                            let barterMateUser: BarterMateUser = AmplifyUserConverter.toBarterMateModel(user: amplifiedUser)!
                            chatUserResults.append(barterMateUser)
                            group.leave()
                        }
                        group.notify(queue: DispatchQueue.main) {
                            _ = completion(chatUserResults)
                        }
                        return chatUserResults
                    }
                }
            }
        func barterMateMessageTask (completion: @escaping ([BarterMateMessage]) -> [BarterMateMessage]) {
                do {
                    Task {
                        try await chat.ChatMessages!.fetch()
                        let chatMessagesList: List<Message> = chat.ChatMessages!
                        let group = DispatchGroup()
                        var chatMessageResults: [BarterMateMessage] = []
                        for chatMessage in chatMessagesList {
                                group.enter()
                                let barterMateMessage: BarterMateMessage = AmplifyMessageConverter.toBarterMateModel(message: chatMessage)
                                chatMessageResults.append(barterMateMessage)
                                group.leave()
                        }
                        group.notify(queue: DispatchQueue.main) {
                            _ = completion(chatMessageResults)
                        }
                        return chatMessageResults
                    }
                }
        }

            let barterMateChat = BarterMateChat(
                id: Identifier(value: chat.id),
                name: chat.name,
                messages: nil,
                users: nil,
                fetchMessagesClosure: barterMateMessageTask,
                fetchUsersClosure: barterMateUserTask
             )

            return barterMateChat
    }

    static func toAmplifyModel(chat: BarterMateChat) -> Chat {
        let amplifyChatMessages: List<Message> = List(elements: chat.messages!.map { message in
            AmplifyMessageConverter.toAmplifyModel(message: message)
        })

        let amplifyUsers: List<User> = List(elements: chat.users!.map { user in
            AmplifyUserConverter.toAmplifyModel(user: user)
        })

        var amplifyChat = Chat(id: chat.id.value,
                               ChatMessages: amplifyChatMessages, ChatUsers: [], name: chat.name)
        let amplifyChatUsers: List<UserChat> = List(elements: amplifyUsers.map { user in
            UserChat(chat: amplifyChat, user: user)
        })
        amplifyChat.ChatUsers = amplifyChatUsers
        return amplifyChat
    }

}

struct AmplifyUserChatAdapter {
    static func toAmplifyModel(user: BarterMateUser, chat: BarterMateChat) -> UserChat {
        let amplifyChat = AmplifyChatConverter.toAmplifyModel(chat: chat)
        let amplifyUser = AmplifyUserConverter.toAmplifyModel(user: user)
        let amplifyUserChat = UserChat(chat: amplifyChat,
                                       user: amplifyUser)
        return amplifyUserChat
    }
}
