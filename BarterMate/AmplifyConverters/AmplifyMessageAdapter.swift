//
//  AmplifyMessageAdapter.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Amplify
import Foundation

struct AmplifyMessageAdapter {
    
    static func toBarterMateModel(message: Message) -> BarterMateMessage {
//        let amplifyUser = message.SentBy
//        let sentBy = AmplifyUserConverter.toBarterMateModel(user: message.SentBy)
//        let sentIn = AmplifyChatAdapter.toBarterMateModel(chat: message.SentIn!, completion: {_ in })

        func barterMateUserTask (completion: @escaping (BarterMateUser) -> BarterMateUser) -> Void {
            do {
                Task {
                    let amplifiedUser: User = try await message.SentBy!
//                            ?? User(id: "404", username: "User not Found")
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
//                                                    (
//                                                    sentBy ??
//                                                    AmplifyUserConverter.toBarterMateModel(user: User(id: "404", username: "User not Found")))!,
                                            createdAt: message.createdAt.foundationDate,
                                            content: message.content)
        
        return barterMateMessage
    }
    
    static func toAmplifyModel(message: BarterMateMessage) -> Message {
//       print("Sent IN: ", message.sentIn?.id.value)
//       print("Sent BY: ", message.sentBy?.id.value)
        let amplifyMessage = Message(id: message.id.value,
                                     createdAt: Temporal.DateTime(message.createdAt),
                                     content: message.content,
                                     SentIn:
                                        (message.sentIn != nil) ?
                                     AmplifyChatAdapter.toAmplifyModel(chat: message.sentIn!) : nil,
                                     SentBy:
                                        (message.sentIn != nil) ? AmplifyUserConverter.toAmplifyModel(user: message.sentBy!) : nil,
                                     sentInID: (message.sentIn != nil) ? message.sentIn?.id.value : nil)
        
        return amplifyMessage
    }
    
}
