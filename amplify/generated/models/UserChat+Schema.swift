// swiftlint:disable all
import Amplify
import Foundation

extension UserChat {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case chat
    case user
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userChat = UserChat.keys
    
    model.pluralName = "UserChats"
    
    model.attributes(
      .index(fields: ["chatId"], name: "byChat"),
      .index(fields: ["userId"], name: "byUser"),
      .primaryKey(fields: [userChat.id])
    )
    
    model.fields(
      .field(userChat.id, is: .required, ofType: .string),
      .belongsTo(userChat.chat, is: .required, ofType: Chat.self, targetNames: ["chatId"]),
      .belongsTo(userChat.user, is: .required, ofType: User.self, targetNames: ["userId"]),
      .field(userChat.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(userChat.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension UserChat: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}