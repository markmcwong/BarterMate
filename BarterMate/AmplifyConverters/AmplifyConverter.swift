//
//  AmplifyAdapter.swift
//  BarterMate
//
//  Created by Zico on 29/3/23.
//

import Foundation
import Amplify

struct AmplifyConverter {
    
    static func toBarterMateModel(model: Model) -> (any ListElement)? {
        switch model {
        case is Item:
            return AmplifyItemConverter.toBarterMateModel(item: model as! Item)
        case is Request:
            return AmplifyRequestConverter.toBarterMateModel(request: model as! Request)
        case is Posting:
            return AmplifyPostingConverter.toBarterMateModel(posting: model as! Posting)
        case is Chat:
            return AmplifyChatAdapter.toBarterMateModel(chat: model as! Chat)
        case is Message:
            return AmplifyMessageAdapter.toBarterMateModel(message: model as! Message)
        case is User:
            return AmplifyUserConverter.toBarterMateModel(user: model as! User)
        case is Transaction:
            return AmplifyTransactionConverter.toBarterMateModel(transaction: model as! Transaction)
        default:
            return nil
        }
    }
    
    static func toAmplifyModel(model: any ListElement) -> Model? {
        switch model {
        case is BarterMateItem:
            return AmplifyItemConverter.toAmplifyModel(item: model as! BarterMateItem)
        case is BarterMateRequest:
            return AmplifyRequestConverter.toAmplifyModel(request: model as! BarterMateRequest)
        case is BarterMatePosting:
            return AmplifyPostingConverter.toAmplifyModel(posting: model as! BarterMatePosting)
        case is BarterMateChat:
            return AmplifyChatAdapter.toAmplifyModel(chat: model as! BarterMateChat)
        case is BarterMateMessage:
            return AmplifyMessageAdapter.toAmplifyModel(message: model as! BarterMateMessage)
        case is BarterMateTransaction:
            return AmplifyTransactionConverter.toAmplifyModel(transaction: model as! BarterMateTransaction)
        default:
            return nil
        }
    }
    
    static func toAmplifyModelType(type: any ListElement.Type) -> (Model.Type)? {
        switch type {
        case is BarterMateChat.Type:
            return Chat.self
        case is BarterMateMessage.Type:
            return Message.self
        default:
            return nil
        }
    }
}

