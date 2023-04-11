// swiftlint:disable all
import Amplify
import Foundation

public struct UserTransaction: Model {
  public let id: String
  public var user: User
  public var transaction: Transaction
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      user: User,
      transaction: Transaction) {
    self.init(id: id,
      user: user,
      transaction: transaction,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      user: User,
      transaction: Transaction,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.user = user
      self.transaction = transaction
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
