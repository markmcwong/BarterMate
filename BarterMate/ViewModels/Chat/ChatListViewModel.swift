////
////  ChatListViewModel.swift
////  BarterMate
////
////  Created by mark on 20/3/2023.
////
//
//import Combine
//import Foundation
//import Amplify
//
//@MainActor
//class ChatListViewModel: ObservableObject {
//    @Published private(set) var loadedPostings: [Chat] = [Chat]()
//    @Published var isPostingSynced = false
//
//    private var subscribers = Set<AnyCancellable>()
//
//    var chatService: ChatService
//
//    init(manager: ServiceManager = AppServiceManager.shared) {
//        self.chatService = manager.chatService
//
//    }
//}
//
//
