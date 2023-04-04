// swiftlint:disable all
import Amplify
import Foundation

extension Chat {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case ChatMessages
    case ChatUsers
    case name
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let chat = Chat.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Chats"
    
    model.attributes(
      .primaryKey(fields: [chat.id])
    )
    
    model.fields(
      .field(chat.id, is: .required, ofType: .string),
      .hasMany(chat.ChatMessages, is: .optional, ofType: Message.self, associatedWith: Message.keys.SentIn),
      .hasMany(chat.ChatUsers, is: .optional, ofType: UserChat.self, associatedWith: UserChat.keys.chat),
      .field(chat.name, is: .optional, ofType: .string),
      .field(chat.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(chat.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Chat: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}