// swiftlint:disable all
import Amplify
import Foundation

public struct UserTransaction: Model {
  public let id: String
  internal var _user: LazyReference<User>
  public var user: User   {
      get async throws { 
        try await _user.require()
      } 
    }
  internal var _transaction: LazyReference<Transaction>
  public var transaction: Transaction   {
      get async throws { 
        try await _transaction.require()
      } 
    }
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
      self._user = LazyReference(user)
      self._transaction = LazyReference(transaction)
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
  public mutating func setUser(_ user: User) {
    self._user = LazyReference(user)
  }
  public mutating func setTransaction(_ transaction: Transaction) {
    self._transaction = LazyReference(transaction)
  }
  public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      _user = try values.decodeIfPresent(LazyReference<User>.self, forKey: .user) ?? LazyReference(identifiers: nil)
      _transaction = try values.decodeIfPresent(LazyReference<Transaction>.self, forKey: .transaction) ?? LazyReference(identifiers: nil)
      createdAt = try? values.decode(Temporal.DateTime?.self, forKey: .createdAt)
      updatedAt = try? values.decode(Temporal.DateTime?.self, forKey: .updatedAt)
  }
  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(id, forKey: .id)
      try container.encode(_user, forKey: .user)
      try container.encode(_transaction, forKey: .transaction)
      try container.encode(createdAt, forKey: .createdAt)
      try container.encode(updatedAt, forKey: .updatedAt)
  }
}