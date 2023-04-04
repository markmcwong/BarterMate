//
//  AddItemFormViewModel.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//
import Combine
import UIKit

class AddItemFormViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var imageUrl: String?
    @Published var errorMessage = ""
    @Published var itemList: ModelList<BarterMateItem>
    @Published var image: UIImage?
    let ownerId: Identifier<BarterMateUser>
    
    let storageService = AmplifyStorageService()
    
    init(itemList: ModelList<BarterMateItem>,
         ownerId: Identifier<BarterMateUser>) {
        self.itemList = itemList
        self.ownerId = ownerId
    }
    
    func addItem() {
        guard validateItem() else {
            return
        }
        let newItem = BarterMateItem(name: name,
                                     description: description,
                                     imageUrl: imageUrl,
                                     ownerId: ownerId,
                                     createdAt: .now,
                                     updatedAt: .now)
        if let image = image {
            let pictureKey = "\(ownerId.value)\(newItem.id.value)"
            newItem.imageUrl = pictureKey
            if let pngData = image.pngData() {
                newItem.imageData = pngData
                Task {
                    storageService.uploadImage(key: pictureKey, pngData)
                }
            }
        }
        itemList.saveItem(element: newItem)
        itemList.insert(model: newItem)
    }
    
    func validateItem() -> Bool {
        guard name != "" else {
            errorMessage = "Item Name Cannot be Empty"
            return false
        }
        
        guard description != "" else {
            errorMessage = "Description Cannot be Empty"
            return false
        }
        
        return true
    }
}
