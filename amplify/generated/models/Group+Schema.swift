// swiftlint:disable all
import Amplify
import Foundation

extension Group {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case description
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let group = Group.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Groups"
    
    model.attributes(
      .primaryKey(fields: [group.id])
    )
    
    model.fields(
      .field(group.id, is: .required, ofType: .string),
      .field(group.name, is: .optional, ofType: .string),
      .field(group.description, is: .optional, ofType: .string),
      .field(group.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(group.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
    public class Path: ModelPath<Group> { }
    
    public static var rootPath: PropertyContainerPath? { Path() }
}

extension Group: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
extension ModelPath where ModelType == Group {
  public var id: FieldPath<String>   {
      string("id") 
    }
  public var name: FieldPath<String>   {
      string("name") 
    }
  public var description: FieldPath<String>   {
      string("description") 
    }
  public var createdAt: FieldPath<Temporal.DateTime>   {
      datetime("createdAt") 
    }
  public var updatedAt: FieldPath<Temporal.DateTime>   {
      datetime("updatedAt") 
    }
}