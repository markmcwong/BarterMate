//
//  AmplifyItemFacade.swift
//  BarterMate
//
//  Created by Zico on 2/4/23.
//

import Foundation
import Amplify

class AmplifyItemFacade: ItemFacade {
    var delegate: (any ItemFacadeDelegate)?
    
    func getItemById(id: Identifier<BarterMateItem>) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            print("id is: " + "\(id)")
            
            guard let amplifyItem = try await Amplify.DataStore.query(Item.self, byId: id.value) else {
                return
            }

            guard let barterMateItem = AmplifyItemConverter.toBarterMateModel(item: amplifyItem) else {
                return
            }

            delegate.update(item: barterMateItem)
            
        }
    }
}
