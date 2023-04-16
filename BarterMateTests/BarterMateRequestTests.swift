//
//  BarterMateRequestTests.swift
//  BarterMateTests
//
//  Created by Zico on 16/4/23.
//

import XCTest
@testable import BarterMate

class BarterMateRequestTests: XCTestCase {
    
    func testInit_returnRequestWithCorrectDetails() {
        let createdAt = Date.now
        let updatedAt = Date.now
        
        let request = BarterMateRequest(id: Identifier(value: "1"),
                                        description: "Desc",
                                        ownerId: Identifier(value: "a"),
                                        createdAt: createdAt,
                                        updatedAt: updatedAt)
        
        XCTAssertEqual(request.id, Identifier<BarterMateRequest>(value: "1"))
        XCTAssertEqual(request.description, "Desc")
        XCTAssertEqual(request.ownerId, Identifier<BarterMateUser>(value: "a"))
        XCTAssertEqual(request.createdAt, createdAt)
        XCTAssertEqual(request.updatedAt, updatedAt)
    }
}
