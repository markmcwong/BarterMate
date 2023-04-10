// swiftlint:disable all
import Amplify
import Foundation

extension Item {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case description
    case image
    case categories
    case userID
    case imageKey
    case transactionID
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let item = Item.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Items"
    
    model.attributes(
      .index(fields: ["userID"], name: "byUser"),
      .index(fields: ["transactionID"], name: "byTransaction"),
      .primaryKey(fields: [item.id])
    )
    
    model.fields(
      .field(item.id, is: .required, ofType: .string),
      .field(item.name, is: .optional, ofType: .string),
      .field(item.description, is: .optional, ofType: .string),
      .field(item.image, is: .optional, ofType: .string),
      .hasMany(item.categories, is: .optional, ofType: Category.self, associatedWith: Category.keys.itemID),
      .field(item.userID, is: .required, ofType: .string),
      .field(item.imageKey, is: .optional, ofType: .string),
      .field(item.transactionID, is: .optional, ofType: .string),
      .field(item.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(item.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Item: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}