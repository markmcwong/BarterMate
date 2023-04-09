// swiftlint:disable all
import Amplify
import Foundation

public struct Transaction: Model {
  public let id: String
  public var status: TransactionStatus?
  public var users: List<UserTransaction>?
  public var itemPool: List<Item>?
  public var userLocked: [UserLocked?]?
  public var userCompleted: [UserCompleted?]?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      status: TransactionStatus? = nil,
      users: List<UserTransaction>? = [],
      itemPool: List<Item>? = [],
      userLocked: [UserLocked?]? = nil,
      userCompleted: [UserCompleted?]? = nil) {
    self.init(id: id,
      status: status,
      users: users,
      itemPool: itemPool,
      userLocked: userLocked,
      userCompleted: userCompleted,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      status: TransactionStatus? = nil,
      users: List<UserTransaction>? = [],
      itemPool: List<Item>? = [],
      userLocked: [UserLocked?]? = nil,
      userCompleted: [UserCompleted?]? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.status = status
      self.users = users
      self.itemPool = itemPool
      self.userLocked = userLocked
      self.userCompleted = userCompleted
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}