// swiftlint:disable all
import Amplify
import Foundation

public struct UserCompleted: Embeddable {
  var userId: String?
  var completed: Bool?
}