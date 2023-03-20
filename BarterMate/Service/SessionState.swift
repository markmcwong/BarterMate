//
//  SessionState.swift
//  BarterMate
//
//  Created by Zico on 14/3/23.
//

import Amplify

enum SessionState {
    case signedOut
    case signedIn(_ user: AuthUser)
    case initializing
}
