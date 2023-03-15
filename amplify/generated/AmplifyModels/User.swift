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
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      username: String? = nil,
      Transactions: List<UserTransaction>? = [],
      Postings: List<Posting>? = [],
      Requests: List<Request>? = [],
      Items: List<Item>? = []) {
    self.init(id: id,
      username: username,
      Transactions: Transactions,
      Postings: Postings,
      Requests: Requests,
      Items: Items,
      createdAt: nil,
      updatedAt: nil)
  }
    
  internal init(id: String = UUID().uuidString,
      username: String? = nil,
      Transactions: List<UserTransaction>? = [],
      Postings: List<Posting>? = [],
      Requests: List<Request>? = [],
      Items: List<Item>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.username = username
      self.Transactions = Transactions
      self.Postings = Postings
      self.Requests = Requests
      self.Items = Items
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
