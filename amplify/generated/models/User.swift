// swiftlint:disable all
import Amplify
import Foundation

public struct User: Model {
  public let id: String
  public var username: String?
  public var Transactions: List<UserTransaction>?
  public var Postings: List<Posting>?
  public var Requests: List<Request>?
  public var Items: List<Item>?
  public var Chats: List<UserChat>?
  public var SentMessages: List<Message>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      username: String? = nil,
      Transactions: List<UserTransaction>? = [],
      Postings: List<Posting>? = [],
      Requests: List<Request>? = [],
      Items: List<Item>? = [],
      Chats: List<UserChat>? = [],
      SentMessages: List<Message>? = []) {
    self.init(id: id,
      username: username,
      Transactions: Transactions,
      Postings: Postings,
      Requests: Requests,
      Items: Items,
      Chats: Chats,
      SentMessages: SentMessages,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      username: String? = nil,
      Transactions: List<UserTransaction>? = [],
      Postings: List<Posting>? = [],
      Requests: List<Request>? = [],
      Items: List<Item>? = [],
      Chats: List<UserChat>? = [],
      SentMessages: List<Message>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.username = username
      self.Transactions = Transactions
      self.Postings = Postings
      self.Requests = Requests
      self.Items = Items
      self.Chats = Chats
      self.SentMessages = SentMessages
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}