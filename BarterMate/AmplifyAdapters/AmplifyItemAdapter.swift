//
//  AmplifyItemAdapter.swift
//  BarterMate
//
//  Created by Zico on 27/3/23.
//

import Amplify
import Foundation

struct AmplifyItemAdapter {
    private static let dataStoreService = AmplifyGenericModelService<Item>()
    
    static func toBarterMateModel(item: Item) -> BarterMateItem? {
        guard let name = item.name,
              let description = item.description,
              let createdAt = item.createdAt,
              let updatedAt = item.updatedAt else {
            return nil
        }
        
        
        
        let convertedItem = BarterMateItem(id: Identifier(value: item.id),
                                  name: name,
                                  description: description,
                                  imageUrl: item.image,
                                  ownerId: Identifier<BarterMateUser>(value: item.userID),
                                  createdAt: createdAt.foundationDate,
                                  updatedAt: updatedAt.foundationDate)
        
        return convertedItem
    }
    
    static func toAmplifyModel(item: BarterMateItem) -> Item {
        let amplifyItem = Item(id: item.id.value,
                               name: item.name,
                               description: item.description,
                               image: item.imageUrl,
                               userID: item.ownerId.value)
        
        return amplifyItem
    }
    
}
