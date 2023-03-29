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
        default:
            return nil
        }
    }
    
    static func toAmplifyModel(model: any ListElement) -> Model? {
        switch model {
        case is BarterMateItem:
            return AmplifyItemAdapter.toAmplifyModel(item: model as! BarterMateItem)
        default:
            return nil
        }
    }
}
