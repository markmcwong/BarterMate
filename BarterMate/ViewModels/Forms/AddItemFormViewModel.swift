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
    
    init(ownerId: Identifier<BarterMateUser>,
         itemList: ModelList<BarterMateItem>) {
        self.ownerId = ownerId
        self.itemList = itemList
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
    }
    
    private func validateItem() -> Bool {
        guard name != "" else {
            errorMessage = "Item Name Cannot be Empty"
            return false
        }
        
        guard description != "" else {
            errorMessage = "Description Cannot be Empty"
            return false
        }
        
        guard image != nil else {
            errorMessage = "Pls select an Image"
            return false
        }
        
        return true
    }
}
