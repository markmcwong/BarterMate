// swiftlint:disable all
import Amplify
import Foundation

public struct Posting: Model {
  public let id: String
  public var createdAt: Temporal.DateTime?
  public var userID: String
  internal var _item: LazyReference<Item>
  public var item: Item?   {
      get async throws { 
        try await _item.get()
      } 
    }
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
      self._item = LazyReference(item)
      self.updatedAt = updatedAt
      self.postingItemId = postingItemId
  }
  public mutating func setItem(_ item: Item? = nil) {
    self._item = LazyReference(item)
  }
  public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      createdAt = try? values.decode(Temporal.DateTime?.self, forKey: .createdAt)
      userID = try values.decode(String.self, forKey: .userID)
      _item = try values.decodeIfPresent(LazyReference<Item>.self, forKey: .item) ?? LazyReference(identifiers: nil)
      updatedAt = try? values.decode(Temporal.DateTime?.self, forKey: .updatedAt)
      postingItemId = try? values.decode(String?.self, forKey: .postingItemId)
  }
  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(id, forKey: .id)
      try container.encode(createdAt, forKey: .createdAt)
      try container.encode(userID, forKey: .userID)
      try container.encode(_item, forKey: .item)
      try container.encode(updatedAt, forKey: .updatedAt)
      try container.encode(postingItemId, forKey: .postingItemId)
  }
}