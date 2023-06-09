// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "de4624ea13ea4571aa8149b7fc653e5b"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Message.self)
    ModelRegistry.register(modelType: Chat.self)
    ModelRegistry.register(modelType: User.self)
    ModelRegistry.register(modelType: Request.self)
    ModelRegistry.register(modelType: Posting.self)
    ModelRegistry.register(modelType: Transaction.self)
    ModelRegistry.register(modelType: Group.self)
    ModelRegistry.register(modelType: Category.self)
    ModelRegistry.register(modelType: Item.self)
    ModelRegistry.register(modelType: UserChat.self)
    ModelRegistry.register(modelType: UserTransaction.self)
  }
}