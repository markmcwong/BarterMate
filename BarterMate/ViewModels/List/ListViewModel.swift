//
//  ListViewModel.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//

import Foundation
import Combine

class ListViewModel<T: ListElement>: ObservableObject {
    @Published var user: BarterMateUser?
    @Published var modelList: ModelList<T>
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: BarterMateUser?, modelList: ModelList<T>) {
        self.user = user
        self.modelList = modelList
        modelList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
    
    func updateElements(items: [T]){
        modelList.elements = items
    }
    
    func deleteItem(item: T) {
        modelList.delete(element: item)
        modelList.remove(model: item)
    }
    
    func saveItem(item: T) {
        modelList.insert(model: item)
        modelList.saveItem(element: item)
    }
}

