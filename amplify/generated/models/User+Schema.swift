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
    case profilePic
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
      .field(user.profilePic, is: .optional, ofType: .string),
      .field(user.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(user.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
    public class Path: ModelPath<User> { }
    
    public static var rootPath: PropertyContainerPath? { Path() }
}

extension User: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
extension ModelPath where ModelType == User {
  public var id: FieldPath<String>   {
      string("id") 
    }
  public var username: FieldPath<String>   {
      string("username") 
    }
  public var Transactions: ModelPath<UserTransaction>   {
      UserTransaction.Path(name: "Transactions", isCollection: true, parent: self) 
    }
  public var Postings: ModelPath<Posting>   {
      Posting.Path(name: "Postings", isCollection: true, parent: self) 
    }
  public var Requests: ModelPath<Request>   {
      Request.Path(name: "Requests", isCollection: true, parent: self) 
    }
  public var Items: ModelPath<Item>   {
      Item.Path(name: "Items", isCollection: true, parent: self) 
    }
  public var Chats: ModelPath<UserChat>   {
      UserChat.Path(name: "Chats", isCollection: true, parent: self) 
    }
  public var SentMessages: ModelPath<Message>   {
      Message.Path(name: "SentMessages", isCollection: true, parent: self) 
    }
  public var profilePic: FieldPath<String>   {
      string("profilePic") 
    }
  public var createdAt: FieldPath<Temporal.DateTime>   {
      datetime("createdAt") 
    }
  public var updatedAt: FieldPath<Temporal.DateTime>   {
      datetime("updatedAt") 
    }
}