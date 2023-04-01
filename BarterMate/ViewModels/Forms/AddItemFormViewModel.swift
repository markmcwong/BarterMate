//
//  AddItemFormViewModel.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//
import Combine

class AddItemFormViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var imageUrl: String?
    @Published var errorMessage = ""
    @Published var itemList: ModelList<BarterMateItem>
    let ownerId: Identifier<BarterMateUser>
    
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
