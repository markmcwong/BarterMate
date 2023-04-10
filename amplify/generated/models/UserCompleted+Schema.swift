// swiftlint:disable all
import Amplify
import Foundation

extension UserCompleted {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case userId
    case completed
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userCompleted = UserCompleted.keys
    
    model.pluralName = "UserCompleteds"
    
    model.fields(
      .field(userCompleted.userId, is: .optional, ofType: .string),
      .field(userCompleted.completed, is: .optional, ofType: .bool)
    )
    }
}