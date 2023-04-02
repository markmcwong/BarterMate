//
//  AmplifyListFacade.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import Amplify
import Foundation
import os

class AmplifyListFacade<U: ListElement>: ModelListFacade {

    typealias BarterMateModel = U
    
    var delegate: ModelList<U>?
    
    func setDelegate(delegate: any ModelListFacadeDelegate) {
        guard let delegate = delegate as? ModelList<U> else {
            print("No delegate available")
            return
        }
//        print("Correct delegate type")
        self.delegate = delegate
    }
    
    func save(model: any ListElement) {
        Task {
            do {
                guard let amplifyModel = AmplifyConverter.toAmplifyModel(model: model) else {
                    return
                }
                _ = try await Amplify.DataStore.save(amplifyModel)
            } catch {
                os_log("Error saving item into Amplify")
            }
        }
    }
    
    func delete(model: any ListElement) {
        Task {
            do {
                guard let amplifyModel = AmplifyConverter.toAmplifyModel(model: model) else {
                    return
                }
                _ = try await Amplify.DataStore.delete(amplifyModel)
            } catch {
                os_log("Error deleting item from Amplify")
            }
        }
    }
    
    func getModelsById(of userId: Identifier<BarterMateUser>) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            guard let type = convertToAmplifyType(type: U.typeName) else {
                return
            }
            let amplifyModelList = try await Amplify.DataStore.query(type.self,
                                                             where: Ownable.userID == userId.value)
            

            let barterMateModels = amplifyModelList.compactMap {
                AmplifyConverter.toBarterMateModel(model: $0)
            }

            if let barterMateModels = barterMateModels as? [U] {
                delegate.insertAll(models: barterMateModels)
            }
            
        }
    }
    
    func getModelsById(of userId: Identifier<BarterMateUser>, limit: Int) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            guard let type = convertToAmplifyType(type: U.typeName) else {
                return
            }
            
            let amplifyModelList = try await Amplify.DataStore.query(type.self,
                                                             where: Ownable.userID == userId.value,
                                                                     paginate: .page(0, limit: UInt(limit)))
            let barterMateModels = amplifyModelList.compactMap {
                AmplifyConverter.toBarterMateModel(model: $0)
            }

            if let barterMateModels = barterMateModels as? [BarterMateModel] {
                delegate.insertAll(models: barterMateModels)
            }
        }
    }
    
    
    func getEveryoneModels() {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            guard let type = convertToAmplifyType(type: U.typeName) else {
                print("cannot convert to amplify type")
                return
            }
            
            let amplifyModelList = try await Amplify.DataStore.query(type.self)
            
            let barterMateModels = amplifyModelList.compactMap {
                AmplifyConverter.toBarterMateModel(model: $0)
            }

            if let barterMateModels = barterMateModels as? [U] {
                delegate.insertAll(models: barterMateModels)
            }
        }
    }
    
    
    func getMessageModelsByChatId(chatId: String) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            let m = Message.keys
            let amplifyMessageModels = try await Amplify.DataStore.query(Message.self, where: m.chatID.eq(chatId))
            let barterMateModels = amplifyMessageModels.compactMap {
                AmplifyMessageAdapter.toBarterMateModel(message: $0)
            }

            if let barterMateModels = barterMateModels as? [U] {
                delegate.insertAll(models: barterMateModels)
            }
        }
    }
    
    func getChatModels() {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            guard let type = convertToAmplifyType(type: U.typeName) else {
                print("cannot convert to amplify type")
                return
            }
            
            let amplifyModelList = try await Amplify.DataStore.query(type.self)
            let barterMateModels = amplifyModelList.compactMap {
                AmplifyChatAdapter.toBarterMateModel(chat: $0 as! Chat) { barterMateChat in
                    delegate.insert(model: barterMateChat as! U)
                }
            }

            if let barterMateModels = barterMateModels as? [U] {
                delegate.insertAll(models: barterMateModels)
            }
        }
    }
    
    func getEveryoneModels(limit: Int) {
        guard let delegate = delegate else {
            return
        }
        
        Task {
            guard let type = convertToAmplifyType(type: U.typeName) else {
                return
            }
            
            let amplifyModelList = try await Amplify.DataStore.query(type,
                                                                     paginate: .page(0, limit: UInt(limit)))
            
            let barterMateModels = amplifyModelList.compactMap {
                AmplifyConverter.toBarterMateModel(model: $0)
            }

            if let barterMateModels = barterMateModels as? [U] {
                delegate.insertAll(models: barterMateModels)
            }
        }
    }
    
    private func convertToAmplifyType(type: String) -> Model.Type? {
        switch type {
        case "BarterMateItem":
            return Item.self
        case "BarterMateRequest":
            return Request.self
        case "BarterMatePosting":
            return Posting.self
        case "BarterMateChat":
            return Chat.self
        default:
            return nil
        }
    }

}

enum Ownable: String, ModelKey {
    case userID
}
