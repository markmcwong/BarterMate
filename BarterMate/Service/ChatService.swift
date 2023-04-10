//
//  ChatService.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

import Foundation
import Amplify

//protocol ChatService {
//
//    func createChat(chatName: String, users: [User]) async throws -> Chat
//    func fetchChat(id: String) async throws -> Chat?
////    func fetchMessagesByChat(chatID: String) async throws -> [Message]
//    func fetchChatsByUser(userID: String) async throws -> [Chat]
//    func createMessage(chat: Chat, sentBy: User, content: String) async throws -> Message
//
//    func query(where predicate: QueryPredicate?,
//               sort sortInput: QuerySortInput?,
//               paginate paginationInput: QueryPaginationInput?) async throws -> [Posting]
//
//    func query(byId: String) async throws -> Posting?
//}

//protocol MessageClientProtocol {
//    func subscribe(chatId: String, completion: @escaping (Result<Message, Error>) -> Void) -> Cancellable
//    func unsubscribe(chatId: String)
//    func sendMessage(_ message: Message, completion: @escaping (Result<Void, Error>) -> Void)
//}

class ChatService {
    static func getCurrentUserChats(id: String) async -> [BarterMateChat] {
//        Task {
        do {
            let response = try await Amplify.API.query(request: .getCurrentUserChats(byId: id))
            switch response {
            case .success(let data):
                if let items:JSONValue = data.value(at: "items") {
                    var chatArrayResult: [BarterMateChat] = []
//                    print("todoJSON : ", items)
                    let encodedItems = try? JSONEncoder().encode(items)
                    let JSONArray = try? JSONDecoder().decode(Array<JSONValue>.self, from: encodedItems!)
                    for chatJSON in JSONArray! {
                        if let chatData = try? JSONEncoder().encode(chatJSON.value(at: "chat")),
                           let chat = try? JSONDecoder().decode(Chat.self, from: chatData) {
                            chatArrayResult.append(BarterMateChat(id: Identifier(value: chat.id), name: chat.name,  messages: [], users: [], fetchMessagesClosure: nil, fetchUsersClosure: nil))
                        }
                    }
                    print(chatArrayResult)
                    return (chatArrayResult)
                }
            case .failure(let errorResponse):
                print("Response contained errors: \(errorResponse)")
                return []
            }
        }
        catch let error {
            print("error: ", error.localizedDescription)
            return []
        }
        return []
    }
}

extension GraphQLRequest {
    static func getCurrentUserChats(byId id: String) -> GraphQLRequest<JSONValue> {
        let operationName = "listUserChats"
        let document = """
        query getCurrentUserChats($id: ID!) {
          \(operationName)(filter: {userId: {eq: $id}}) {
            items {
              chat {
                id
                name
              }
            }
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
