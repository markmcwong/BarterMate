// swiftlint:disable all
import Amplify
import Foundation

public struct Message: Model {
  public let id: String
  public var createdAt: Temporal.DateTime
  public var content: String
  internal var _SentIn: LazyReference<Chat>
  public var SentIn: Chat?   {
      get async throws { 
        try await _SentIn.get()
      } 
    }
  internal var _SentBy: LazyReference<User>
  public var SentBy: User?   {
      get async throws { 
        try await _SentBy.get()
      } 
    }
  public var sentInID: String?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      createdAt: Temporal.DateTime,
      content: String,
      SentIn: Chat? = nil,
      SentBy: User? = nil,
      sentInID: String? = nil) {
    self.init(id: id,
      createdAt: createdAt,
      content: content,
      SentIn: SentIn,
      SentBy: SentBy,
      sentInID: sentInID,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      createdAt: Temporal.DateTime,
      content: String,
      SentIn: Chat? = nil,
      SentBy: User? = nil,
      sentInID: String? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.createdAt = createdAt
      self.content = content
      self._SentIn = LazyReference(SentIn)
      self._SentBy = LazyReference(SentBy)
      self.sentInID = sentInID
      self.updatedAt = updatedAt
  }
  public mutating func setSentIn(_ SentIn: Chat? = nil) {
    self._SentIn = LazyReference(SentIn)
  }
  public mutating func setSentBy(_ SentBy: User? = nil) {
    self._SentBy = LazyReference(SentBy)
  }
  public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      createdAt = try values.decode(Temporal.DateTime.self, forKey: .createdAt)
      content = try values.decode(String.self, forKey: .content)
      _SentIn = try values.decodeIfPresent(LazyReference<Chat>.self, forKey: .SentIn) ?? LazyReference(identifiers: nil)
      _SentBy = try values.decodeIfPresent(LazyReference<User>.self, forKey: .SentBy) ?? LazyReference(identifiers: nil)
      sentInID = try? values.decode(String?.self, forKey: .sentInID)
      updatedAt = try? values.decode(Temporal.DateTime?.self, forKey: .updatedAt)
  }
  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(id, forKey: .id)
      try container.encode(createdAt, forKey: .createdAt)
      try container.encode(content, forKey: .content)
      try container.encode(_SentIn, forKey: .SentIn)
      try container.encode(_SentBy, forKey: .SentBy)
      try container.encode(sentInID, forKey: .sentInID)
      try container.encode(updatedAt, forKey: .updatedAt)
  }
}