//
//  BarterMateUserTest.swift
//  BarterMateTests
//
//  Created by Zico on 16/4/23.
//

import XCTest
@testable import BarterMate

class BarterMateUserTests: XCTestCase {
    
    func testCreateEmptyUser_ReturnUserWithEmptyDetails() {
        let user = BarterMateUser.getUserWithId(id: Identifier(value: "1"))
        
        XCTAssertEqual(user.id, Identifier(value: "1"))
        XCTAssertEqual(user.username, "")
    }
    
    func testInit_returnUserWithCorrectDetails() {
        let user = BarterMateUser(id: Identifier(value: "1"),
                                  username: "zico")
        
        XCTAssertEqual(user.id, Identifier(value: "1"))
        XCTAssertEqual(user.username, "zico")
    }
    
    func testUpdate_updateUserDetailsCorrectly() {
        let user = BarterMateUser(id: Identifier(value: "1"),
                                  username: "Alex")
        
        let updatedId = Identifier<BarterMateUser>(value: "2")
        let updatedUsername = "Tristan"
        let updatedUser = BarterMateUser(id: updatedId, username: updatedUsername)
        user.update(user: updatedUser)
        
        XCTAssertEqual(user.id, updatedId)
        XCTAssertEqual(user.username, updatedUsername)
    }
    
}
