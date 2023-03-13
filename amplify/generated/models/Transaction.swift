// swiftlint:disable all
import Amplify
import Foundation

public struct Transaction: Model {
  public let id: String
  public var status: TransactionStatus?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      status: TransactionStatus? = nil) {
    self.init(id: id,
      status: status,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      status: TransactionStatus? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.status = status
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}