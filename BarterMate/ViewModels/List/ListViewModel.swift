//
//  ListViewModel.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//

import Foundation

class ListViewModel<T: ListElement>: ObservableObject {
    @Published var user: BarterMateUser
    @Published var modelList: ModelList<T>
    
    init(user: BarterMateUser, modelList: ModelList<T>) {
        self.user = user
        self.modelList = modelList
    }
    
    func deleteItem(item: T) {
        modelList.delete(element: item)
        modelList.remove(model: item)
    }
}
