// swiftlint:disable all
import Amplify
import Foundation

public struct Chat: Model {
  public let id: String
  public var ChatMessages: List<Message>?
  public var ChatUsers: List<User>?
  public var name: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      ChatMessages: List<Message> = [],
      ChatUsers: List<User> = [],
      name: String? = nil) {
    self.init(id: id,
      ChatMessages: ChatMessages,
      ChatUsers: ChatUsers,
      name: name,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      ChatMessages: List<Message> = [],
      ChatUsers: List<User> = [],
      name: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.ChatMessages = ChatMessages
      self.ChatUsers = ChatUsers
      self.name = name
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}