// swiftlint:disable all
import Amplify
import Foundation

public struct Message: Model {
  public let id: String
  public var createdAt: Temporal.DateTime
  public var content: String
  public var SentIn: Chat?
  public var SentBy: User?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      createdAt: Temporal.DateTime,
      content: String,
      SentIn: Chat? = nil,
      SentBy: User? = nil) {
    self.init(id: id,
      createdAt: createdAt,
      content: content,
      SentIn: SentIn,
      SentBy: SentBy,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      createdAt: Temporal.DateTime,
      content: String,
      SentIn: Chat? = nil,
      SentBy: User? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.createdAt = createdAt
      self.content = content
      self.SentIn = SentIn
      self.SentBy = SentBy
      self.updatedAt = updatedAt
  }
}