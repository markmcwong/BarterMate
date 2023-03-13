// swiftlint:disable all
import Amplify
import Foundation

public struct Category: Model {
  public let id: String
  public var categoryName: String?
  public var itemID: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      categoryName: String? = nil,
      itemID: String) {
    self.init(id: id,
      categoryName: categoryName,
      itemID: itemID,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      categoryName: String? = nil,
      itemID: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.categoryName = categoryName
      self.itemID = itemID
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}