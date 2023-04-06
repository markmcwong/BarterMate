//
//  BarterMateModel.swift
//  BarterMate
//
//  Created by mark on 6/4/2023.
//

import Foundation

public protocol BarterMateModel: Codable, Comparable, Equatable {
}

class BarterMateModelExample: BarterMateModel {
    static func < (lhs: BarterMateModelExample, rhs: BarterMateModelExample) -> Bool {
        return true
    }
    
    static func == (lhs: BarterMateModelExample, rhs: BarterMateModelExample) -> Bool {
        return true
    }
}


protocol MyProtocol {
    func doSomething()
}

class MyClass: MyProtocol {
    func doSomething() {
        print("Doing something...")
    }
}

func myFunction(param: MyProtocol) {
    param.doSomething()
}
