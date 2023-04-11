// swiftlint:disable all
import Amplify
import Foundation

extension Category {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case categoryName
    case itemID
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let category = Category.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Categories"
    
    model.attributes(
      .index(fields: ["itemID"], name: "byItem"),
      .primaryKey(fields: [category.id])
    )
    
    model.fields(
      .field(category.id, is: .required, ofType: .string),
      .field(category.categoryName, is: .optional, ofType: .string),
      .field(category.itemID, is: .required, ofType: .string),
      .field(category.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(category.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
    public class Path: ModelPath<Category> { }
    
    public static var rootPath: PropertyContainerPath? { Path() }
}

extension Category: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
extension ModelPath where ModelType == Category {
  public var id: FieldPath<String>   {
      string("id") 
    }
  public var categoryName: FieldPath<String>   {
      string("categoryName") 
    }
  public var itemID: FieldPath<String>   {
      string("itemID") 
    }
  public var createdAt: FieldPath<Temporal.DateTime>   {
      datetime("createdAt") 
    }
  public var updatedAt: FieldPath<Temporal.DateTime>   {
      datetime("updatedAt") 
    }
}