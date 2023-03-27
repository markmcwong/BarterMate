//
//  ItemViewModel.swift
//  BarterMate
//
//  Created by Zico on 16/3/23.
//

import SwiftUI
import Amplify
import Combine

class ItemViewModel: ObservableObject {
    
    var item: BarterMateItem
    var ownerName: String?
    var isLoading = true

    init(item: BarterMateItem) {
        self.item = item
    }
    
}

