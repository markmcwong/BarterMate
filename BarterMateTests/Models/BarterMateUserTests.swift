//
//  BarterMateUserTests.swift
//  BarterMateTests
//
//  Created by Zico on 16/4/23.
//

import XCTest
@testable import BarterMate

class BarterMateUserTests: XCTestCase {
    
    func testCreateEmptyUser_returnUserWithEmptyDetails() {
        let emptyUser = BarterMateUser.createEmptyEvent(id: Identifier(value: "1"))
        
        XCTAssertEqual(emptyUser.username, "")
        XCTAssertEqual(emptyUser.id, Identifier(value: "1"))
        XCTAssertEqual(emptyUser.userFa)
    }
    
    func testUpdate_UpdateAllField() {
        let user = BarterMateUser(id: Identifier(value: "Alex"), username: "Alex")
        let updatedUsername = "Tristan"
        let updatedId = Identifier(value: "78")
        let updatedUser = BarterMateUser(id: updatedId, username: updatedUsername)
        user.update(updatedUser)
        
        XCTAssertEqual(user.username, updatedUsername)
        XCTAssertEqual(user.id, updatedId)
    }
}
