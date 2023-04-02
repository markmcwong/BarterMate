// swiftlint:disable all
import Amplify
import Foundation

extension User {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case username
    case Transactions
    case Postings
    case Requests
    case Items
    case Chats
    case SentMessages
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let user = User.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Users"
    
    model.attributes(
      .primaryKey(fields: [user.id])
    )
    
    model.fields(
      .field(user.id, is: .required, ofType: .string),
      .field(user.username, is: .optional, ofType: .string),
      .hasMany(user.Transactions, is: .optional, ofType: UserTransaction.self, associatedWith: UserTransaction.keys.user),
      .hasMany(user.Postings, is: .optional, ofType: Posting.self, associatedWith: Posting.keys.userID),
      .hasMany(user.Requests, is: .optional, ofType: Request.self, associatedWith: Request.keys.userID),
      .hasMany(user.Items, is: .optional, ofType: Item.self, associatedWith: Item.keys.userID),
      .hasMany(user.Chats, is: .optional, ofType: UserChat.self, associatedWith: UserChat.keys.user),
      .hasMany(user.SentMessages, is: .optional, ofType: Message.self, associatedWith: Message.keys.SentBy),
      .field(user.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(user.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension User: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}