// swiftlint:disable all
import Amplify
import Foundation

extension Message {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case createdAt
    case content
    case SentIn
    case SentBy
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let message = Message.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Messages"
    
    model.attributes(
      .index(fields: ["chatID"], name: "byChat"),
      .index(fields: ["userID"], name: "byUser"),
      .primaryKey(fields: [message.id])
    )
    
    model.fields(
      .field(message.id, is: .required, ofType: .string),
      .field(message.createdAt, is: .required, ofType: .dateTime),
      .field(message.content, is: .required, ofType: .string),
      .belongsTo(message.SentIn, is: .optional, ofType: Chat.self, targetNames: ["chatID"]),
      .belongsTo(message.SentBy, is: .optional, ofType: User.self, targetNames: ["userID"]),
      .field(message.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Message: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}