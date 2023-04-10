// swiftlint:disable all
import Amplify
import Foundation

extension UserTransaction {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case user
    case transaction
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userTransaction = UserTransaction.keys
    
    model.pluralName = "UserTransactions"
    
    model.attributes(
      .index(fields: ["userId"], name: "byUser"),
      .index(fields: ["transactionId"], name: "byTransaction"),
      .primaryKey(fields: [userTransaction.id])
    )
    
    model.fields(
      .field(userTransaction.id, is: .required, ofType: .string),
      .belongsTo(userTransaction.user, is: .required, ofType: User.self, targetNames: ["userId"]),
      .belongsTo(userTransaction.transaction, is: .required, ofType: Transaction.self, targetNames: ["transactionId"]),
      .field(userTransaction.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(userTransaction.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
    public class Path: ModelPath<UserTransaction> { }
    
    public static var rootPath: PropertyContainerPath? { Path() }
}

extension UserTransaction: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
extension ModelPath where ModelType == UserTransaction {
  public var id: FieldPath<String>   {
      string("id") 
    }
  public var user: ModelPath<User>   {
      User.Path(name: "user", parent: self) 
    }
  public var transaction: ModelPath<Transaction>   {
      Transaction.Path(name: "transaction", parent: self) 
    }
  public var createdAt: FieldPath<Temporal.DateTime>   {
      datetime("createdAt") 
    }
  public var updatedAt: FieldPath<Temporal.DateTime>   {
      datetime("updatedAt") 
    }
}