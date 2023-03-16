// swiftlint:disable all
import Amplify
import Foundation

extension Message {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case SentTo
    case SentBy
    case createdAt
    case content
    case updatedAt
    case messageSentById
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
      .primaryKey(fields: [message.id])
    )
    
    model.fields(
      .field(message.id, is: .required, ofType: .string),
      .belongsTo(message.SentTo, is: .required, ofType: Chat.self, targetNames: ["chatID"]),
      .hasOne(message.SentBy, is: .required, ofType: User.self, associatedWith: User.keys.id, targetNames: ["messageSentById"]),
      .field(message.createdAt, is: .required, ofType: .dateTime),
      .field(message.content, is: .required, ofType: .string),
      .field(message.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(message.messageSentById, is: .required, ofType: .string)
    )
    }
}

extension Message: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}