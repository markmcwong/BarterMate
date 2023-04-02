//
//  AmplifyPostingAdapter.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//

import Foundation
import Amplify

struct AmplifyPostingConverter {
    
    static func toBarterMateModel(posting: Posting) -> BarterMatePosting? {

        guard let itemId = posting.postingItemId,
              let createdAt = posting.createdAt,
              let updatedAt = posting.updatedAt else {
            return nil
        }
        
//        Task {
//            do {
//                let item = try await Amplify.DataStore.query(Item.self, byId: itemId)
//
//                guard let item = item else {
//                    return
//                }
//
//                let convertedItem = AmplifyConverter.toBarterMateModel(model: item)
//
//                guard let convertedItem = convertedItem as? BarterMateItem else {
//                    return
//                }
//
//                let barterMatePosting = BarterMatePosting(id: Identifier(value: posting.id),
//                                                          item: convertedItem,
//                                                          createdAt: createdAt.foundationDate,
//                                                          updatedAt: updatedAt.foundationDate)
//
//                return barterMatePosting
//            }
//        }
        
        let convertedItem = BarterMateItem.getItemWithId(id: Identifier(value: itemId))


        let barterMatePosting = BarterMatePosting(id: Identifier(value: posting.id),
                                                  item: convertedItem,
                                                  createdAt: createdAt.foundationDate,
                                                  updatedAt: updatedAt.foundationDate)

        return barterMatePosting
    }
    
    
    static func toAmplifyModel(posting: BarterMatePosting) -> Posting? {
        
        let convertedItem = AmplifyConverter.toAmplifyModel(model: posting.item)
        
        guard let convertedItem = convertedItem as? Item else {
            return nil
        }
        
        let amplifyPosting = Posting(id: posting.id.value,
                                     userID: posting.item.ownerId.value,
                                     item: convertedItem,
                                     postingItemId: convertedItem.id)
        
        return amplifyPosting
    }
}
