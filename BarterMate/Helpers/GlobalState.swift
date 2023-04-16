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

    private var subscribers = Set<AnyCancellable>()

    @Published var userId: String? = "213f11fc-0384-4c44-a8c0-e87f1b77b41e"
    @Published var user: BarterMateUser?
    @Published var currentChat: BarterMateChat?

    private init() { }

    func updateUser(userId: String, user: User) {
        self.userId = userId
        self.user = AmplifyUserConverter.toBarterMateModel(user: user)
    }

}
