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
        print("Item: ", item, amplifiedItem)
//        let saveSink = Amplify.Publisher.create {
        Task {
            do {
                try await Amplify.DataStore.save(amplifiedItem)
                try await Amplify.DataStore.start()
                print("Datastore done")
            } catch let error {
                print("saving error: ", error.localizedDescription)
            }
        }
//
//        }.sink {
//            if case let .failure(error) = $0 {
//                completion(.failure(error))
//            }
//        } receiveValue: {
//            completion(.success(()))
//        }
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
        
//        if modelType.typeName == "BarterMateMessage" {
//            print("queryChatMessageSubscriptionHelper is used")
//            return queryChatMessageSubscriptionHelper(id: GlobalState.shared.currentChat!.id.value, completion: completion)
//        } else {
            print("querySubscriptionHelper is used")
            return querySubscriptionHelper(amplifiedType, modelType, where: predicate, sort: sort, completion: completion)
//        }
    }

    func queryChatMessageSubscriptionHelper<I: ListElement>(id: String, completion: @escaping ([I]) -> Void) -> Cancellable {
//        Task {
            let sequence: AmplifyAsyncThrowingSequence<GraphQLSubscriptionEvent<JSONValue>> = Amplify.API.subscribe(request: .getCurrentUserChats(byId: id))
            let subscription = Amplify.Publisher.create(sequence)
            let allUpdates = subscription.sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let dataStoreError):
                        fatalError(dataStoreError.localizedDescription)
                    case .finished:
                        print("finished")
                        break
                    }
                }, receiveValue: { result in
                    do {
                        switch result {
                        case .connection(let subscriptionConnectionState):
                            print("Subscription connect state is \(subscriptionConnectionState)")
                        case .data(let data):
                            print("status is: ", data)
                            let dataJSON = try data.get()
                            if let items:JSONValue = dataJSON.value(at: "items") {
                                var chatArrayResult: [I] = []
                                print("todoJSON : ", items)
                                let encodedItems = try? JSONEncoder().encode(items)
                                let JSONArray = try? JSONDecoder().decode(Array<JSONValue>.self, from: encodedItems!)
                                for messageJSON in JSONArray! {
                                    if let chatItem = messageJSON.value(at: "SentBy"),
                                       let chatData = try? JSONEncoder().encode(chatItem),
                                       let userItem = messageJSON.value(at: "SentIn"),
                                       let userData = try? JSONEncoder().encode(userItem),
                                       let user = try? JSONDecoder().decode(User.self, from: chatData),
                                       let chat = try? JSONDecoder().decode(Chat.self, from: userData),
                                       let encodedId = try? JSONEncoder().encode(messageJSON.value(at: "id")),
                                       let id = (try? JSONDecoder().decode(String.self, from: encodedId)),
                                       let encodedContent = try? JSONEncoder().encode(messageJSON.value(at: "content")),
                                       let content = (try? JSONDecoder().decode(String.self, from: encodedContent)) {
                                        let encodedIsDeleted = try? JSONEncoder().encode(messageJSON.value(at: "_deleted"))
                                        let bool = (try? JSONDecoder().decode(Bool.self, from: encodedIsDeleted!))
                                        
                                        print(messageJSON.value(at: "_deleted")!)
                                        //                            print(encodedIsDeleted)
                                        if(bool == nil || !bool!){
                                            let chat = BarterMateChat(id: Identifier(value: chat.id), name: chat.name, fetchMessagesClosure: nil, fetchUsersClosure: nil)
                                            let user = AmplifyUserConverter.toBarterMateModel(user: user)
                                            chatArrayResult.append(BarterMateMessage(id: Identifier(value: id), sentIn: chat, sentBy: user, fetchUserClosure: nil, createdAt: .now, content: content) as! I)
                                        }
                                    }
                                }
                                print(chatArrayResult)
                                completion(chatArrayResult)
                            }
                        }
                    }
                    catch let error {
                        print("error: ", error.localizedDescription)
                    }
                }
        )
        return allUpdates
    }
    
}

extension AnyCancellable: Cancellable {
    func cancelSubscription() {
        self.cancel()
    }
}

extension GraphQLRequest {
    static func getChatMessages(byId id: String) -> GraphQLRequest<JSONValue> {
        let operationName = "listMessages"
        let document = """
        query getChatMessages($id: ID!) {
          \(operationName)getChatMessages(filter: {chatID: {eq: $id}}) {
          items {
            id
            content
            SentBy {
              username
              profilePic
            }
            SentIn {
              id
              name
              createdAt
            }
            _deleted
          }
        }
        """
        return GraphQLRequest<JSONValue>(
            document: document,
            variables: ["id": id],
            responseType: JSONValue.self,
            decodePath: operationName
        )
    }
}
