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
    case login
<<<<<<< Updated upstream
//    case home
=======
    case home
>>>>>>> Stashed changes
//    case profile
}

class Router: ObservableObject {
    @Published var currentScreen: AppScreen = .login
<<<<<<< Updated upstream
=======

    static let singleton = Router()

    private init() { }
>>>>>>> Stashed changes
    
    func navigate(to screen: AppScreen) {
        currentScreen = screen
    }
}
