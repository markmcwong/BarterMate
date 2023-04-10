//
//  ModelList.swift
//  BarterMate
//
//  Created by Zico on 30/3/23.
//

import Foundation

// Attempt to make generic List

class ModelList<T: ListElement>: ObservableObject {
    @Published var elements: [T] = []
    
    private var modelListFacade: (any ModelListFacade)?
    
    static func empty() -> ModelList {
        let modelList = ModelList()
        modelList.setFacade()
        modelList.modelListFacade?.setDelegate(delegate: modelList)
        return modelList
    }
    
    static func of(_ ownerId: Identifier<BarterMateUser>) -> ModelList {
        let modelList = ModelList()
        modelList.setFacade()
        modelList.modelListFacade?.setDelegate(delegate: modelList)
        modelList.modelListFacade?.getModelsById(of: ownerId)
        return modelList
    }
    
    static func all() -> ModelList {
        let modelList = ModelList()
        modelList.setFacade()
        modelList.modelListFacade?.setDelegate(delegate: modelList)
        if(T.self.typeName == "BarterMateChat") {
            print("Getting chat models")
            modelList.modelListFacade?.getChatModels()
        } else {
            modelList.modelListFacade?.getEveryoneModels()
        }
        return modelList
    }
    
    static func allMessage(chatId: String) -> ModelList {
        print("all Message: ", chatId)
        let modelList = ModelList()
        modelList.setFacade()
        modelList.modelListFacade?.setDelegate(delegate: modelList)
        modelList.modelListFacade?.getMessageModelsByChatId(chatId: chatId)
        print(modelList.elements.description)
        return modelList
    }
    
    private init() {}
    
    func setFacade() {
        modelListFacade = AmplifyListFacade<T>()
    }
    
    func insert(model: T) {
        if !elements.contains(model) {
            elements.append(model)
        }
    }
    
    func insertAll(models: [T]) {
        let filteredElement = models.filter { !elements.contains($0) }
        self.elements.append(contentsOf: filteredElement)
    }
    
    func remove(model: T) {
        if let index = elements.firstIndex(of: model) {
            self.elements.remove(at: index)
        }
    }
    
    func saveItem(element: T) {
        modelListFacade?.save(model: element)
        insert(model: element)
    }
    
    func delete(element: T) {
        modelListFacade?.delete(model: element)
        remove(model: element)
    }
    
    func filter(_ isIncluded: (any ListElement) -> Bool) {
        elements = elements.filter(isIncluded)
    }
    
    

}

extension ModelList: ModelListFacadeDelegate {
    typealias Model = T
}


