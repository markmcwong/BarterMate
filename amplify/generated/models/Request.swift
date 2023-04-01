// swiftlint:disable all
import Amplify
import Foundation

public struct Request: Model {
  public let id: String
  public var description: String?
  public var createdAt: Temporal.DateTime?
  public var userID: String
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      description: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      userID: String) {
    self.init(id: id,
      description: description,
      createdAt: createdAt,
      userID: userID,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      description: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      userID: String,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.description = description
      self.createdAt = createdAt
      self.userID = userID
      self.updatedAt = updatedAt
  }
}

