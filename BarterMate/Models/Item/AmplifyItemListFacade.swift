//
//  AmplifyItemListFacade.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import Amplify
import Foundation
import os

class AmplifyItemListFacade: ItemListFacade {
    var delegate: ItemListFacadeDelegate?
    
    let dataStoreService = AmplifyGenericModelService<Item>()

    func save(item: BarterMateItem) {
        Task {
            do {
                _ = try await dataStoreService.save(AmplifyItemAdapter.toAmplifyModel(item: item))
            } catch {
                os_log("Error saving item into Amplify")
            }
        }
    }
    
    func delete(item: BarterMateItem) {
        Task {
            do {
                _ = try await dataStoreService.delete(AmplifyItemAdapter.toAmplifyModel(item: item))
            } catch {
                os_log("Error deleting item from Amplify")
            }
        }
    }
    
    func getItemsById(of userId: Identifier<User>) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            do {
                let itemKeys = Item.keys
                let itemList = try await Amplify.DataStore.query(Item.self,
                                                                 where: itemKeys.userID == userId.value)
                let barterMateItems = itemList.compactMap {
                    AmplifyItemAdapter.toBarterMateModel(item: $0)
                }
                delegate.insertAll(items: barterMateItems)
            }
        }
    }

    
    
}
