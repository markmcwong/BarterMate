//
//  GlobalState.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

import Foundation
import Amplify
import Combine

class GlobalState: ObservableObject {
    static let shared = GlobalState()
    
//    private let authService: AuthService
    private var subscribers = Set<AnyCancellable>()
    
    @Published var userId: String?
    @Published var user: BarterMateUser?
    @Published var currentChat: BarterMateChat?
    
    private init() { }
    
    func updateUser(userId: String, user: User) {
        self.userId = userId
        self.user = AmplifyUserConverter.toBarterMateModel(user: user)
    }
//    private init(manager: ServiceManager = AppServiceManager.shared) {
//        manager.eventsPublisher.toAnyPublisher
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] completion in
//
//            }, receiveValue: { [weak self] event in
//                self?.onReceive(event: event)
//            })
//            .store(in: &subscribers)
//    }
//
//    func onReceive(event: DataStoreServiceEvent) {
//        switch event {
//        case .userSignedIn:
//            Task {
//                self.userId = try await authService.getCurrentUser()!.userId
//                print("Fetched userId: ", self.userId)
//            }
//        case .userSignedOut:
//            self.userId = nil
//        default:
//            return
//        }
//    }
}
