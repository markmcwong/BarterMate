//
//  AmplifyItemAdapter.swift
//  BarterMate
//
//  Created by Zico on 27/3/23.
//

import Amplify
import Foundation

struct AmplifyItemConverter {

    static func toBarterMateModel(item: Item) -> BarterMateItem? {
        guard let name = item.name,
              let description = item.description,
              let createdAt = item.createdAt,
              let updatedAt = item.updatedAt,
              let key = item.imageKey else {
            return nil
        }

        let barterMateItem = BarterMateItem(id: Identifier(value: item.id),
                                            name: name,
                                            description: description,
                                            imageUrl: key,
                                            ownerId: Identifier<BarterMateUser>(value: item.userID),
                                            createdAt: createdAt.foundationDate,
                                            updatedAt: updatedAt.foundationDate)

        return barterMateItem
    }

    static func toAmplifyModel(item: BarterMateItem) -> Item {
        let amplifyItem = Item(id: item.id.value,
                               name: item.name,
                               description: item.description,
                               userID: item.ownerId.value,
                               imageKey: item.imageUrl)

        return amplifyItem
    }

}
