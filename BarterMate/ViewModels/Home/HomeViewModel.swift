//
//  HomeViewModel.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    let user: BarterMateUser
    
    init(user: BarterMateUser) {
        self.user = user
    }
}
