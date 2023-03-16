// swiftlint:disable all
import Amplify
import Foundation

public struct UserChat: Model {
  public let id: String
  public var chat: Chat
  public var user: User
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
      self.chat = chat
      self.user = user
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}