//
//  BarterMateItemTests.swift
//  BarterMateTests
//
//  Created by Zico on 16/4/23.
//

import XCTest
@testable import BarterMate

class BarterMateItemTests: XCTestCase {
    func testCreateUnavailableItem_returnItemWithNoDetails() {
        let item = BarterMateItem.createUnavailableItem()
        
        XCTAssertEqual(item.id, Identifier(value: ""))
        XCTAssertEqual(item.name, "")
        XCTAssertEqual(item.description, "")
        XCTAssertEqual(item.imageUrl, nil)
        XCTAssertEqual(item.ownerId, Identifier(value: ""))
    }
    
    func testInit_returnUserWithCorrectDetails() {
        
    }
    
    func testUpdate_updateItemDetailsCorrectly() {
        let item = BarterMateItem(id: Identifier(value: "1"),
                                  name: "testItem",
                                  description: "testDescription",
                                  imageUrl: nil,
                                  ownerId: Identifier(value: "a"),
                                  createdAt: .distantPast,
                                  updatedAt: .distantPast)
        
        let updatedId = Identifier<BarterMateItem>(value: "2")
        let updatedName = "updatedItem"
        let updatedDescription = "updatedDescription"
        let updatedImageUrl = "SomeUrl"
        let updatedOwnerId = Identifier<BarterMateUser>(value: "b")
        let updatedCreatedAt = Date.now
        let updatedUpdatedAt = Date.now
        let updatedItem = BarterMateItem(id: updatedId,
                                         name: updatedName,
                                         description: updatedDescription,
                                         imageUrl: updatedImageUrl,
                                         ownerId: updatedOwnerId,
                                         createdAt: updatedCreatedAt,
                                         updatedAt: updatedUpdatedAt)
        item.update(item: updatedItem)
        
        XCTAssertEqual(item.id, updatedId)
        XCTAssertEqual(item.name, updatedName)
        XCTAssertEqual(item.description, updatedDescription)
        XCTAssertEqual(item.imageUrl, updatedImageUrl)
        XCTAssertEqual(item.ownerId, updatedOwnerId)
        XCTAssertEqual(item.createdAt, updatedCreatedAt)
        XCTAssertEqual(item.updatedAt, updatedUpdatedAt)
    }
}
