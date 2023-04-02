//
//  AppServiceManager.swift
//  BarterMate
//
//  Created by Zico on 16/3/23.
//

class AppServiceManager: ServiceManager {

    private init() {}
    
    static let shared = AppServiceManager()
    
//    let authService: AuthService = AmplifyAuthService()
//    let dataStoreService: DataStoreService = AmplifyDataStoreService()
    let storageService: StorageService = AmplifyStorageService()
//    let itemService: ItemService = AmplifyItemService()
//    let requestService: RequestService = AmplifyRequestService()
//    let postingService: PostingService = AmplifyPostingService()
//    let userService: UserService = AmplifyUserService()
    let eventsPublisher: EventsPublisher = AmplifyEventsPublisher.shared
//    var chatService: ChatService = AmplifyChatService()
    func configure() { }
}

