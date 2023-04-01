// swiftlint:disable all
import Amplify
import Foundation

public struct Posting: Model {
  public let id: String
  public var createdAt: Temporal.DateTime?
  public var userID: String
  public var item: Item?
  public var updatedAt: Temporal.DateTime?
  public var postingItemId: String?
  
  public init(id: String = UUID().uuidString,
      createdAt: Temporal.DateTime? = nil,
      userID: String,
      item: Item? = nil,
      postingItemId: String? = nil) {
    self.init(id: id,
      createdAt: createdAt,
      userID: userID,
      item: item,
      updatedAt: nil,
      postingItemId: postingItemId)
  }
  internal init(id: String = UUID().uuidString,
      createdAt: Temporal.DateTime? = nil,
      userID: String,
      item: Item? = nil,
      updatedAt: Temporal.DateTime? = nil,
      postingItemId: String? = nil) {
      self.id = id
      self.createdAt = createdAt
      self.userID = userID
      self.item = item
      self.updatedAt = updatedAt
      self.postingItemId = postingItemId
  }
}