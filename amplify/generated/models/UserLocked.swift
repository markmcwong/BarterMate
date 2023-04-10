// swiftlint:disable all
import Amplify
import Foundation

public struct UserLocked: Embeddable {
  var userId: String?
  var locked: Bool?
}