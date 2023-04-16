//
//  AmplifyMessageAdapter.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Amplify
import Foundation

struct AmplifyMessageConverter {

    static func toBarterMateModel(message: Message) -> BarterMateMessage {


        func barterMateUserTask (completion: @escaping (BarterMateUser) -> BarterMateUser) {
            do {
                Task {
                    let amplifiedUser: User = try await message.SentBy!
                    let barterMateUser: BarterMateUser = AmplifyUserConverter.toBarterMateModel(user: amplifiedUser)!
                    completion(barterMateUser)
                    return barterMateUser
                }
            }
        }

        let barterMateMessage = BarterMateMessage(id: Identifier(value: message.id),
                                                  sentIn: nil,
                                                  sentBy: nil,
                                                  fetchUserClosure: barterMateUserTask,
                                                  createdAt: message.createdAt.foundationDate,
                                                  content: message.content)

        return barterMateMessage
    }

    static func toAmplifyModel(message: BarterMateMessage) -> Message {
        let amplifyMessage = Message(id: message.id.value,
                                     createdAt: Temporal.DateTime(message.createdAt),
                                     content: message.content,
                                     SentIn:
                                        (message.sentIn != nil) ?
                                     AmplifyChatConverter.toAmplifyModel(chat: message.sentIn!) : nil,
                                     SentBy:
                                        (message.sentIn != nil) ? AmplifyUserConverter.toAmplifyModel(user: message.sentBy!) : nil,
                                     sentInID: (message.sentIn != nil) ? message.sentIn?.id.value : nil)

        return amplifyMessage
    }

}
