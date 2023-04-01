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
        let sentBy = AmplifyUserAdapter.toBarterMateModel(user: message.SentBy)
        
        let barterMateMessage = BarterMateMessage(id: Identifier(value: message.id),
                                            chatId: Identifier(value: message.chatID),
                                                  sentBy: (sentBy ?? AmplifyUserAdapter.toBarterMateModel(user: User(id: "404", username: "User not Found")))!,
                                            createdAt: message.createdAt.foundationDate,
                                            content: message.content)
        
        return barterMateMessage
    }
    
    static func toAmplifyModel(message: BarterMateMessage) -> Message {
        let amplifyMessage = Message(id: message.id.value,
                                     chatID: message.chatId.value,
                                     SentBy: AmplifyUserAdapter.toAmplifyModel(user: message.sentBy),
                                     createdAt: Temporal.DateTime(message.createdAt),
                                     content: message.content,
                                     messageSentById: message.sentBy.id.value)
        
        return amplifyMessage
    }
    
}
