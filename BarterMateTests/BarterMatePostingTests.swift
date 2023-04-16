//
//  BarterMatePostingTests.swift
//  BarterMateTests
//
//  Created by Zico on 16/4/23.
//

import XCTest
@testable import BarterMate

class BarterMatePostingTests: XCTestCase {

    func testInit_returnPostingWithCorrectDetails() {
        
        let createdAt = Date.now
        let updatedAt = Date.now
        
        let posting = BarterMatePosting(id: Identifier(value: "1"),
                                        item: BarterMateItem.createUnavailableItem(),
                                        createdAt: createdAt,
                                        updatedAt: updatedAt)
        
        XCTAssertEqual(posting.id, Identifier<BarterMatePosting>(value: "1"))
        XCTAssertEqual(posting.item, BarterMateItem.createUnavailableItem())
        XCTAssertEqual(posting.createdAt, createdAt)
        XCTAssertEqual(posting.updatedAt, updatedAt)
    }
}
