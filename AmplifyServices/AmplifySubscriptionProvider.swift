//
//  AmplifySubscriptionProvider.swift
//  BarterMate
//
//  Created by mark on 4/4/2023.
//

import Foundation
import Amplify
import Combine

struct AmplifySubscriptionProvider<U: ListElement>: SubscriptionProvider {
    typealias ModelType = U
    
    func cancelSubscription() {}
    
    func save(_ item: ModelType, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let amplifiedItem = AmplifyConverter.toAmplifyModel(model: item) else {
            fatalError("Cannot convert to Amplify Model's equivalent")
        }
        Task {
            do {
                try await Amplify.DataStore.save(amplifiedItem)
                try await Amplify.DataStore.start()
                print("Datastore done")
            } catch let error {
                print("saving error: ", error.localizedDescription)
            }
        }
    }
    
    func querySubscriptionHelper<H: Model, I: ListElement>(_ modelType: H.Type, _ origModelType: I.Type, where predicate: QueryPredicate? = nil, sort: QuerySortInput? = nil,
                                                           completion: @escaping ([I]) -> Void) -> Cancellable {
        print("Predicate is ", predicate.debugDescription)
        let subscription = Amplify.Publisher.create(Amplify.DataStore.observeQuery(for: modelType, where: predicate)).sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let dataStoreError):
                    fatalError(dataStoreError.localizedDescription)
                case .finished:
                    print("finished")
                    break
                }
            }, receiveValue: { querySnapshot in
                print("Query snapshot synced? \(querySnapshot.isSynced)")
                print("Query Snapshot incoming: ", querySnapshot)
                let convertedItems: [I] = querySnapshot.items.compactMap({
                    AmplifyConverter.toBarterMateModel(model: $0)
                }) as! [I]
                print("Converted items: ", convertedItems)
                completion(convertedItems)
        })
        
        return subscription
    }
    
    func querySubscription<L: ListElement>(_ modelType: L.Type, where predicate: QueryPredicate? = nil, sort: QuerySortInput? = nil, completion: @escaping ([L]) -> Void) -> Cancellable {
        
        guard let amplifiedType: Model.Type = AmplifyConverter.toAmplifyModelType(type: modelType) else {
            fatalError("Cannot convert to Amplify Model's equivalent")
        }

        return querySubscriptionHelper(amplifiedType, modelType, where: predicate, sort: sort, completion: completion)
    }
}

extension AnyCancellable: Cancellable {
    func cancelSubscription() {
        self.cancel()
    }
}

//extension GraphQLRequest {
//    static func getChatMessages(byId id: String) -> GraphQLRequest<JSONValue> {
//        let operationName = "listMessages"
//        let document = """
//        query getChatMessages($id: ID!) {
//          \(operationName)getChatMessages(filter: {chatID: {eq: $id}}) {
//          items {
//            id
//            content
//            SentBy {
//              username
//              profilePic
//            }
//            SentIn {
//              id
//              name
//              createdAt
//            }
//            _deleted
//          }
//        }
//        """
//        return GraphQLRequest<JSONValue>(
//            document: document,
//            variables: ["id": id],
//            responseType: JSONValue.self,
//            decodePath: operationName
//        )
//    }
//}
