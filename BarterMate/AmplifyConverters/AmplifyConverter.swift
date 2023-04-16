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
            guard let item = model as? Item else {
                return nil
            }
            return AmplifyItemConverter.toBarterMateModel(item: item)
        case is Request:
            guard let request = model as? Request else {
                return nil
            }
            return AmplifyRequestConverter.toBarterMateModel(request: request)
        case is Posting:
            guard let posting = model as? Posting else {
                return nil
            }
            return AmplifyPostingConverter.toBarterMateModel(posting: posting)
        case is Chat:
            guard let chat = model as? Chat else {
                return nil
            }
            return AmplifyChatAdapter.toBarterMateModel(chat: chat)
        case is Message:
            guard let message = model as? Message else {
                return nil
            }
            return AmplifyMessageAdapter.toBarterMateModel(message: message)
        case is User:
            guard let user = model as? User else {
                return nil
            }
            return AmplifyUserConverter.toBarterMateModel(user: user)
        case is Transaction:
            guard let transaction = model as? Transaction else {
                return nil
            }
            return AmplifyTransactionConverter.toBarterMateModel(transaction: transaction)
        default:
            return nil
        }
    }

    static func toAmplifyModel(model: any ListElement) -> Model? {
        switch model {
        case is BarterMateItem:
            guard let item = model as? BarterMateItem else {
                return nil
            }
            return AmplifyItemConverter.toAmplifyModel(item: item)
        case is BarterMateRequest:
            guard let request = model as? BarterMateRequest else {
                return nil
            }
            return AmplifyRequestConverter.toAmplifyModel(request: request)
        case is BarterMatePosting:
            guard let posting = model as? BarterMatePosting else {
                return nil
            }
            return AmplifyPostingConverter.toAmplifyModel(posting: posting)
        case is BarterMateChat:
            guard let chat = model as? BarterMateChat else {
                return nil
            }
            return AmplifyChatAdapter.toAmplifyModel(chat: chat)
        case is BarterMateMessage:
            guard let message = model as? BarterMateMessage else {
                return nil
            }
            return AmplifyMessageAdapter.toAmplifyModel(message: message)
        case is BarterMateTransaction:
            guard let transaction = model as? BarterMateTransaction else {
                return nil
            }
            return AmplifyTransactionConverter.toAmplifyModel(transaction: transaction)
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
