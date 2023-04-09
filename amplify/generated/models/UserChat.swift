// swiftlint:disable all
import Amplify
import Foundation

public struct UserChat: Model {
  public let id: String
  internal var _chat: LazyReference<Chat>
  public var chat: Chat   {
      get async throws { 
        try await _chat.require()
      } 
    }
  internal var _user: LazyReference<User>
  public var user: User   {
      get async throws { 
        try await _user.require()
      } 
    }
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      chat: Chat,
      user: User) {
    self.init(id: id,
      chat: chat,
      user: user,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      chat: Chat,
      user: User,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self._chat = LazyReference(chat)
      self._user = LazyReference(user)
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
  public mutating func setChat(_ chat: Chat) {
    self._chat = LazyReference(chat)
  }
  public mutating func setUser(_ user: User) {
    self._user = LazyReference(user)
  }
  public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      _chat = try values.decodeIfPresent(LazyReference<Chat>.self, forKey: .chat) ?? LazyReference(identifiers: nil)
      _user = try values.decodeIfPresent(LazyReference<User>.self, forKey: .user) ?? LazyReference(identifiers: nil)
      createdAt = try? values.decode(Temporal.DateTime?.self, forKey: .createdAt)
      updatedAt = try? values.decode(Temporal.DateTime?.self, forKey: .updatedAt)
  }
  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(id, forKey: .id)
      try container.encode(_chat, forKey: .chat)
      try container.encode(_user, forKey: .user)
      try container.encode(createdAt, forKey: .createdAt)
      try container.encode(updatedAt, forKey: .updatedAt)
  }
}