// swiftlint:disable all
import Amplify
import Foundation

public struct Item: Model {
  public let id: String
  public var name: String?
  public var description: String?
  public var image: String?
  public var categories: List<Category>?
  public var userID: String
  public var imageKey: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String? = nil,
      description: String? = nil,
      image: String? = nil,
      categories: List<Category>? = [],
      userID: String,
      imageKey: String? = nil) {
    self.init(id: id,
      name: name,
      description: description,
      image: image,
      categories: categories,
      userID: userID,
      imageKey: imageKey,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String? = nil,
      description: String? = nil,
      image: String? = nil,
      categories: List<Category>? = [],
      userID: String,
      imageKey: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.description = description
      self.image = image
      self.categories = categories
      self.userID = userID
      self.imageKey = imageKey
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}