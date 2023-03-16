// swiftlint:disable all
import Amplify
import Foundation

public struct Message: Model {
  public let id: String
  public var SentTo: Chat
  public var SentBy: User
  public var createdAt: Temporal.DateTime
  public var content: String
  public var updatedAt: Temporal.DateTime?
  public var messageSentById: String
  
  public init(id: String = UUID().uuidString,
      SentTo: Chat,
      SentBy: User,
      createdAt: Temporal.DateTime,
      content: String,
      messageSentById: String) {
    self.init(id: id,
      SentTo: SentTo,
      SentBy: SentBy,
      createdAt: createdAt,
      content: content,
      updatedAt: nil,
      messageSentById: messageSentById)
  }
  internal init(id: String = UUID().uuidString,
      SentTo: Chat,
      SentBy: User,
      createdAt: Temporal.DateTime,
      content: String,
      updatedAt: Temporal.DateTime? = nil,
      messageSentById: String) {
      self.id = id
      self.SentTo = SentTo
      self.SentBy = SentBy
      self.createdAt = createdAt
      self.content = content
      self.updatedAt = updatedAt
      self.messageSentById = messageSentById
  }
}