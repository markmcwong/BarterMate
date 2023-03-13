// swiftlint:disable all
import Amplify
import Foundation

public struct Transaction: Model {
  public let id: String
  public var status: TransactionStatus?
  public var users: List<UserTransaction>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      status: TransactionStatus? = nil,
      users: List<UserTransaction>? = []) {
    self.init(id: id,
      status: status,
      users: users,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      status: TransactionStatus? = nil,
      users: List<UserTransaction>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.status = status
      self.users = users
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}