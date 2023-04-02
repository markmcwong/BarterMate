////
////  AmplifyListFacade.swift
////  BarterMate
////
////  Created by Zico on 28/3/23.
////
//
//import Amplify
//import Foundation
//import os
//
//class OldAmplifyListFacade<U: ListElement, T: Model, Delegate: ModelListFacadeDelegate>: ModelListFacade where Delegate.Model == U {
//
//    typealias BarterMateModel = U
//    typealias AmplifyModel = T
//    
//    var delegate: Delegate?
//    
//    func setDelegate(delegate: any ModelListFacadeDelegate) {
//        guard let delegate = delegate as? Delegate else {
//            return
//        }
//        //print("Correct delegate type")
//        self.delegate = delegate
//    }
//    
//    func save(model: U) {
//        Task {
//            do {
//                guard let amplifyModel = AmplifyAdapter.toAmplifyModel(model: model) else {
//                    return
//                }
//                _ = try await Amplify.DataStore.save(amplifyModel)
//            } catch {
//                os_log("Error saving item into Amplify")
//            }
//        }
//    }
//    
//    func delete(model: BarterMateModel) {
//        Task {
//            do {
//                guard let amplifyModel = AmplifyAdapter.toAmplifyModel(model: model) else {
//                    return
//                }
//                _ = try await Amplify.DataStore.delete(amplifyModel)
//            } catch {
//                os_log("Error deleting item from Amplify")
//            }
//        }
//    }
//    
//    func getModelsById(of userId: Identifier<User>) {
//        guard let delegate = delegate else {
//            return
//        }
//        
//        Task {
//            let amplifyModelList = try await Amplify.DataStore.query(AmplifyModel.self,
//                                                             where: Ownable.userID == userId.value)
//            let barterMateModels = amplifyModelList.compactMap {
//                AmplifyAdapter.toBarterMateModel(model: $0)
//            }
//
//            if let barterMateModels = barterMateModels as? [U] {
//                delegate.insertAll(models: barterMateModels)
//            }
//        }
//    }
//    
//    func getModelsById(of userId: Identifier<User>, limit: Int) {
//        guard let delegate = delegate else {
//            return
//        }
//        
//        Task {
//            let amplifyModelList = try await Amplify.DataStore.query(AmplifyModel.self,
//                                                             where: Ownable.userID == userId.value,
//                                                                     paginate: .page(0, limit: UInt(limit)))
//            let barterMateModels = amplifyModelList.compactMap {
//                AmplifyAdapter.toBarterMateModel(model: $0)
//            }
//
//            if let barterMateModels = barterMateModels as? [BarterMateModel] {
//                delegate.insertAll(models: barterMateModels)
//            }
//        }
//    }
//    
//    
//    func getEveryoneModels() {
//        guard let delegate = delegate else {
//            return
//        }
//        
//        Task {
//            let amplifyModelList = try await Amplify.DataStore.query(AmplifyModel.self)
//            
//            let barterMateModels = amplifyModelList.compactMap {
//                AmplifyAdapter.toBarterMateModel(model: $0)
//            }
//
//            if let barterMateModels = barterMateModels as? [U] {
//                delegate.insertAll(models: barterMateModels)
//            }
//        }
//    }
//    
//    func getEveryoneModels(limit: Int) {
//        guard let delegate = delegate else {
//            return
//        }
//        
//        Task {
//            guard let type = convertToAmplifyType(type: U.typeName) else {
//                return
//            }
//            let amplifyModelList = try await Amplify.DataStore.query(type,
//                                                                     paginate: .page(0, limit: UInt(limit)))
//            
//            let barterMateModels = amplifyModelList.compactMap {
//                AmplifyAdapter.toBarterMateModel(model: $0)
//            }
//
//            if let barterMateModels = barterMateModels as? [U] {
//                delegate.insertAll(models: barterMateModels)
//            }
//        }
//    }
//    
//    private func convertToAmplifyType(type: String) -> Model.Type? {
//        switch type {
//        case "BarterMateItem":
//            return Item.self
//        case "BarterMateRequest":
//            return Request.self
//        case "BarterMatePosting":
//            return Posting.self
//        default:
//            return nil
//        }
//    }
//
//}
//
//extension OldAmplifyListFacade where U == BarterMateItem {
//    typealias AmplifyModel = Item
//}
//
//extension OldAmplifyListFacade where U == BarterMateRequest {
//    typealias AmplifyModel = Request
//}
//
//enum Ownable: String, ModelKey {
//    case userID
//}
