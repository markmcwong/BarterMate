//
//  AmplifyAdapter.swift
//  BarterMate
//
//  Created by Zico on 29/3/23.
//

import Foundation
import Amplify

struct AmplifyAdapter {
    
    static func toBarterMateModel(model: Model) -> (any ListElement)? {
        switch model {
        case is Item:
            return AmplifyItemAdapter.toBarterMateModel(item: model as! Item)
        case is Request:
            return AmplifyRequestAdapter.toBarterMateModel(request: model as! Request)
        case is Posting:
            return AmplifyPostingAdapter.toBarterMateModel(posting: model as! Posting)
        default:
            return nil
        }
    }
    
    static func toAmplifyModel(model: any ListElement) -> Model? {
        switch model {
        case is BarterMateItem:
            return AmplifyItemAdapter.toAmplifyModel(item: model as! BarterMateItem)
        case is BarterMateRequest:
            return AmplifyRequestAdapter.toAmplifyModel(request: model as! BarterMateRequest)
        case is BarterMatePosting:
            return AmplifyPostingAdapter.toAmplifyModel(posting: model as! BarterMatePosting)
        default:
            return nil
        }
    }
}
