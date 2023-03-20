//
//  ServiceManager.swift
//  BarterMate
//
//  Created by Zico on 15/3/23.
//

protocol ServiceManager {
    var authService: AuthService { get }
    var dataStoreService: DataStoreService { get }
    var storageService: StorageService { get }
    var itemService: ItemService { get }
    var requestService: RequestService { get }
    var postingService: PostingService { get }
    var userService: UserService { get }
    var eventsPublisher: EventsPublisher { get }
    
    func configure()
    
}

