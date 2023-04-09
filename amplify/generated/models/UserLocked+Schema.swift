// swiftlint:disable all
import Amplify
import Foundation

extension UserLocked {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case userId
    case locked
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userLocked = UserLocked.keys
    
    model.pluralName = "UserLockeds"
    
    model.fields(
      .field(userLocked.userId, is: .optional, ofType: .string),
      .field(userLocked.locked, is: .optional, ofType: .bool)
    )
    }
}