//
//  ListElementViewModel.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import Foundation

class ListElementViewModel: ObservableObject {
    
    var item: BarterMateItem

    init(item: BarterMateItem) {
        self.item = item
    }
    
}
