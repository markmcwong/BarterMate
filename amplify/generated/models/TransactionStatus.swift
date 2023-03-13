// swiftlint:disable all
import Amplify
import Foundation

public enum TransactionStatus: String, EnumPersistable {
  case completed = "COMPLETED"
  case paymentPending = "PAYMENT_PENDING"
  case confirmationPending = "CONFIRMATION_PENDING"
}