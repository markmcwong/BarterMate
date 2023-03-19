//
//  ActionResult.swift
//  BarterMate
//
//  Created by Mark on 19/3/23.
//

import Foundation

class ActionResult {
    var isSuccess: Bool
    var message: String
    
    init(_ isSuccess: Bool, _ message: String) {
        self.isSuccess = isSuccess
        self.message = message
    }
}
