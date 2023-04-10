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
        print("Item: ", item)
        guard let amplifiedItem = AmplifyConverter.toAmplifyModel(model: item) else {
            fatalError("Cannot convert to Amplify Model's equivalent")
        }
        
        let saveSink = Amplify.Publisher.create {
            try await Amplify.DataStore.save(amplifiedItem)
        }.sink {
            if case let .failure(error) = $0 {
                completion(.failure(error))
            }
        } receiveValue: {
            completion(.success(()))
        }
    }
    
    func querySubscriptionHelper<H: Model, I: ListElement>(_ modelType: H.Type, _ origModelType: I.Type, where predicate: QueryPredicate? = nil, sort: QuerySortInput? = nil,
                                                           completion: @escaping ([I]) -> Void) -> Cancellable {
//                                                           completion: @escaping (Result<[I], DataStoreError>) -> Void) -> Cancellable {
//        guard let amplifiedType = AmplifyConverter.toAmplifyModelType(type: modelType) else {
//            fatalError("Cannot convert to Amplify Model's equivalent")
//        }
//
        let subscription = Amplify.Publisher.create(Amplify.DataStore.observeQuery(for: modelType, where: predicate, sort: sort))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let dataStoreError):
                    fatalError(dataStoreError.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { querySnapshot in
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
