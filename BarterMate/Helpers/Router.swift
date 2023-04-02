//
//  Router.swift
//  BarterMate
//
//  Created by Mark on 18/3/23.
//

import Foundation
import Combine
import SwiftUI

enum AppScreen {
    case profile
    case request
    case posting
    case chat
}

class Router: ObservableObject {
<<<<<<< Updated upstream
    @Published var currentScreen: AppScreen = .profile
    
=======
    @Published var currentScreen: AppScreen = .chat

>>>>>>> Stashed changes
    static let singleton = Router()

    private init() { }
    
    func navigate(to screen: AppScreen) {
        currentScreen = screen
    }
}
