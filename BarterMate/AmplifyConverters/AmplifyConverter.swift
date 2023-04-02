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
<<<<<<< Updated upstream:BarterMate/AmplifyConverters/AmplifyConverter.swift
            return AmplifyPostingConverter.toBarterMateModel(posting: model as! Posting)
=======
            return AmplifyPostingAdapter.toBarterMateModel(posting: model as! Posting)
//        case is Chat:
//            return AmplifyChatAdapter.toBarterMateModel(chat: model as! Chat)
>>>>>>> Stashed changes:BarterMate/AmplifyAdapters/AmplifyAdapter.swift
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
<<<<<<< Updated upstream:BarterMate/AmplifyConverters/AmplifyConverter.swift
            return AmplifyPostingConverter.toAmplifyModel(posting: model as! BarterMatePosting)
=======
            return AmplifyPostingAdapter.toAmplifyModel(posting: model as! BarterMatePosting)
        case is BarterMateChat:
            return AmplifyChatAdapter.toAmplifyModel(chat: model as! BarterMateChat)
>>>>>>> Stashed changes:BarterMate/AmplifyAdapters/AmplifyAdapter.swift
        default:
            return nil
        }
    }
}
