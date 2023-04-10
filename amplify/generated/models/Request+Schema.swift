// swiftlint:disable all
import Amplify
import Foundation

extension Request {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case description
    case createdAt
    case userID
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let request = Request.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Requests"
    
    model.attributes(
      .index(fields: ["userID"], name: "byUser"),
      .primaryKey(fields: [request.id])
    )
    
    model.fields(
      .field(request.id, is: .required, ofType: .string),
      .field(request.description, is: .optional, ofType: .string),
      .field(request.createdAt, is: .optional, ofType: .dateTime),
      .field(request.userID, is: .required, ofType: .string),
      .field(request.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
    public class Path: ModelPath<Request> { }
    
    public static var rootPath: PropertyContainerPath? { Path() }
}

extension Request: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
extension ModelPath where ModelType == Request {
  public var id: FieldPath<String>   {
      string("id") 
    }
  public var description: FieldPath<String>   {
      string("description") 
    }
  public var createdAt: FieldPath<Temporal.DateTime>   {
      datetime("createdAt") 
    }
  public var userID: FieldPath<String>   {
      string("userID") 
    }
  public var updatedAt: FieldPath<Temporal.DateTime>   {
      datetime("updatedAt") 
    }
}