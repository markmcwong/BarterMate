//
//  ItemViewModel.swift
//  BarterMate
//
//  Created by Zico on 16/3/23.
//

import SwiftUI
import Amplify
import Combine

class ItemViewModel: ObservableObject {
    
    var item: Item
    var ownerName: String?
    var dataStoreService: DataStoreService
    var storageService: StorageService
    //var image: Image?
    var isLoading = true
    
    private var subsribers = Set<AnyCancellable>()
    
    init(item: Item, manager: ServiceManager = AppServiceManager.shared) {
        self.item = item
        self.dataStoreService = manager.dataStoreService
        self.storageService = manager.storageService
        Task {
            await getOwnerName()
        }
    }
    
//    private func loadImage(data: Data) {
//        guard let uiImage = UIImage(data: data) else {
//            return
//        }
//
//        image = Image(uiImage: uiImage)
//    }
//
    func deleteItem() async {
        do {
            try await dataStoreService.deleteItem(item)
            guard let key = item.image else {
                return
            }
            _ = try await storageService.removeImage(key: key)
        } catch let error as StorageError {
            Amplify.log.error("\(#function) Error removing image - \(error.localizedDescription)")
        } catch let error as DataStoreError {
            Amplify.log.error("\(#function) Error deleting item - \(error.localizedDescription)")
        } catch {
            
        }
    }
    
    @MainActor
    func getOwnerName() async {
        guard isLoading else {
            return
        }
        do {
            let user = try await dataStoreService.query(User.self, byId: item.userID)
            guard let name = user?.username else {
                return
            }
            ownerName = name
            isLoading = false
        } catch let error as DataStoreError {
            Amplify.log.error("\(#function) Error finding username - \(error.localizedDescription)")
        } catch {
            Amplify.log.error("\(#function) Error removing request - \(error.localizedDescription)")
        }
    }
}
