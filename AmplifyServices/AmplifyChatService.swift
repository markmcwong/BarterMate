//
//  AmplifyChatService.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

import Amplify
import Foundation

class AmplifyChatService: ChatService {
    func getCurrentUserChats(id: String) async -> [BarterMateChat] {
        do {
            let response = try await Amplify.API.query(request: .getCurrentUserChats(byId: id))
            switch response {
            case .success(let data):
                let chatArray = convertToBarterMateChats(data: data)
                return chatArray
            case .failure(let errorResponse):
                print("Response contained errors: \(errorResponse)")
                return []
            }
        } catch {
            print("error: ", error.localizedDescription)
            return []
        }
    }

    func insertUserChats(userChats: [UserChat]) {
        Task {
            do {
                for userChat in userChats {
                    try await Amplify.DataStore.save(userChat)
                }
            } catch {
                print("Saving user chat error: ", error.localizedDescription)
            }
        }
    }
    
    
    func convertToBarterMateChats(data: JSONValue) -> [BarterMateChat] {
        var chatArrayResult: [BarterMateChat] = []
        
        if let items:JSONValue = data.value(at: "items") {
            let encodedItems = try? JSONEncoder().encode(items)
            let JSONArray = try? JSONDecoder().decode(Array<JSONValue>.self, from: encodedItems!)
            for chatJSON in JSONArray! {
                if let chatItem = chatJSON.value(at: "chat"),
                    let chatData = try? JSONEncoder().encode(chatItem),
                    let chat = try? JSONDecoder().decode(Chat.self, from: chatData),
                    let chatUsers = chatItem.value(at: "ChatUsers"),
                    let chatUsersItems:JSONValue = chatUsers.value(at: "items"),
                    let chatUsersData = try? JSONEncoder().encode(chatUsersItems),
                    let chatUsersJSONArray = try? JSONDecoder().decode(Array<JSONValue>.self, from: chatUsersData) {
                    
                    var chatUsers: [BarterMateUser] = []
                    print("loading Chat users")
                    for chatUserJSON in chatUsersJSONArray {
                        print(chatUserJSON)
                        if let chatUserItem = chatUserJSON.value(at: "user"),
                            let chatUserData = try? JSONEncoder().encode(chatUserItem),
                            let chatUser = try? JSONDecoder().decode(User.self, from: chatUserData) {
                            chatUsers.append(BarterMateUser(id: Identifier(value: chatUser.id), username: chatUser.username!))
                        }
                    }
                    print(chatUsers)

                    let encodedIsDeleted = try? JSONEncoder().encode(chatItem.value(at: "_deleted"))
                    let bool = (try? JSONDecoder().decode(Bool.self, from: encodedIsDeleted!))
                    
                    if(bool == nil || !bool!){
                        chatArrayResult.append(BarterMateChat(id: Identifier(value: chat.id), name: chat.name, messages: [], users: chatUsers, fetchMessagesClosure: nil, fetchUsersClosure: nil))
                    }
                }
            }
        }
        
        return chatArrayResult
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
                _deleted
                ChatUsers {
                  items {
                    user {
                      username
                      id
                    }
                  }
                }
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
