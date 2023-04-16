//
//  BarterMateTransactionTests.swift
//  BarterMateTests
//
//  Created by Zico on 16/4/23.
//

import XCTest
@testable import BarterMate

class BarterMateTransactionTest: XCTestCase {
    
    static let bob = BarterMateUser(id: Identifier(value: "B"),
                                    username: "Bob")
    static let alice = BarterMateUser(id: Identifier(value: "A"),
                                      username: "Alice")
    static let charlie = BarterMateUser(id: Identifier(value: "C"),
                                         username: "Charlie")
    
    static let guitar = BarterMateItem(id: Identifier(value: "G"),
                                       name: "Guitar",
                                       description: "6 strings",
                                       imageUrl: nil,
                                       ownerId: bob.id,
                                       createdAt: .now,
                                       updatedAt: .now)
    
    static let shoes = BarterMateItem(id: Identifier(value: "s"),
                                      name: "Shoes",
                                      description: "Size 40",
                                      imageUrl: nil,
                                      ownerId: alice.id,
                                      createdAt: .now,
                                      updatedAt: .now)
    
    static let waterBottle = BarterMateItem(id: Identifier(value: "w"),
                                            name: "water bottle",
                                            description: "500 ml",
                                            imageUrl: nil,
                                            ownerId: charlie.id,
                                            createdAt: .now,
                                            updatedAt: .now)
    
    
    static func createInitiatedTransaction() -> BarterMateTransaction {
        BarterMateTransaction(id: Identifier(value: "1"),
                              participants: [BarterMateTransactionTest.alice],
                              itemPool: [BarterMateTransactionTest.guitar],
                              hasLockedOffer: [],
                              hasCompletedBarter: [],
                              state: .INITIATED)
    }
    
    static func createInitiatedTransactionTwo() -> BarterMateTransaction {
        BarterMateTransaction(id: Identifier(value: "1"),
                              participants: [BarterMateTransactionTest.alice, BarterMateTransactionTest.bob],
                              itemPool: [BarterMateTransactionTest.guitar],
                              hasLockedOffer: [],
                              hasCompletedBarter: [],
                              state: .INITIATED)
    }
    
    static func createLockedTransaction() -> BarterMateTransaction {
        BarterMateTransaction(id: Identifier(value: "2"),
                              participants: [BarterMateTransactionTest.alice, BarterMateTransactionTest.bob],
                              itemPool: [BarterMateTransactionTest.guitar, BarterMateTransactionTest.shoes],
                              hasLockedOffer: [BarterMateTransactionTest.alice.id, BarterMateTransactionTest.bob.id],
                              hasCompletedBarter: [],
                              state: .ITEMLOCKED)
    }
    
    func testInit_returnTransactionWithCorrectDetails() {
        
        let transaction = BarterMateTransaction(id: Identifier(value: "1"),
                                                participants: [BarterMateTransactionTest.alice],
                                                itemPool: [BarterMateTransactionTest.guitar],
                                                hasLockedOffer: [],
                                                hasCompletedBarter: [],
                                                state: .INITIATED)
        
        XCTAssertEqual(transaction.id, Identifier<BarterMateTransaction>(value: "1"))
        XCTAssertTrue(transaction.participants.contains(BarterMateTransactionTest.alice))
        XCTAssertTrue(transaction.itemPool.contains(BarterMateTransactionTest.guitar))
        XCTAssertTrue(transaction.hasLockedOffer.isEmpty)
        XCTAssertTrue(transaction.hasCompletedBarter.isEmpty)
        XCTAssertEqual(transaction.state, TransactionState.INITIATED)
    }
    
    func testAddUser_stateIsInitiated_userIsAdded() {
        let transaction = BarterMateTransactionTest.createInitiatedTransaction()
        
        transaction.addUser(user: BarterMateTransactionTest.charlie)
        
        XCTAssertTrue(transaction.participants.contains(BarterMateTransactionTest.charlie))
    }
    
    func testAddUser_stateIsNotInitiated_userIsNotAdded() {
        let transaction = BarterMateTransactionTest.createLockedTransaction()
        
        transaction.addUser(user: BarterMateTransactionTest.charlie)
        
        XCTAssertFalse(transaction.participants.contains(BarterMateTransactionTest.charlie))
    }
    
    func testAddUser_userAlreadyExist_userIsNotAdded() {
        let transaction = BarterMateTransactionTest.createInitiatedTransaction()
        
        transaction.addUser(user: BarterMateTransactionTest.alice)

        XCTAssertEqual(transaction.participants.count, 1)
    }
    
    func testRemoveUser_userExists_userIsRemoved() {
        let transaction = BarterMateTransactionTest.createInitiatedTransaction()
        
        transaction.removeUser(user: BarterMateTransactionTest.alice)
        
        XCTAssertFalse(transaction.participants.contains(BarterMateTransactionTest.alice))
    }
    
    func testRemoveUser_userDoesNotExists_doNothing() {
        let transaction = BarterMateTransactionTest.createLockedTransaction()
        
        transaction.removeUser(user: BarterMateTransactionTest.bob)
        
        XCTAssertEqual(transaction.participants.count, 2)
    }
    
    func testRemoveUser_stateIsNotInititiated_doNothing() {
        let transaction = BarterMateTransactionTest.createLockedTransaction()
        
        transaction.addUser(user: BarterMateTransactionTest.alice)
        
        XCTAssertEqual(transaction.participants.count, 2)
    }
    
    func testAddItem_stateIsInitiated_addItem() {
        let transaction = BarterMateTransactionTest.createInitiatedTransaction()
        
        transaction.addItem(item: BarterMateTransactionTest.shoes)
        
        XCTAssertTrue(transaction.itemPool.contains(BarterMateTransactionTest.shoes))
    }
    
    func testAddItem_stateIsNotInitiated_doNothing() {
        let transaction = BarterMateTransactionTest.createLockedTransaction()
        
        transaction.addItem(item: BarterMateTransactionTest.waterBottle)
        
        XCTAssertEqual(transaction.itemPool.count, 2)
    }
    
    func testAddItem_itemAlreadyExist_doNothing() {
        let transaction = BarterMateTransactionTest.createInitiatedTransaction()
        
        transaction.addItem(item: BarterMateTransactionTest.guitar)
        
        XCTAssertEqual(transaction.itemPool.count, 1)
    }
    
    func testRemoveItem_itemExistAndStateIsInitiated_removeItem() {
        let transaction = BarterMateTransactionTest.createInitiatedTransaction()
        
        transaction.removeItem(item: BarterMateTransactionTest.guitar)
        
        XCTAssertFalse(transaction.itemPool.contains(BarterMateTransactionTest.guitar))
    }
    
    func testRemoveItem_StateIsNotInitiated_doNothing() {
        let transaction = BarterMateTransactionTest.createLockedTransaction()
        
        transaction.removeItem(item: BarterMateTransactionTest.guitar)
        
        XCTAssertEqual(transaction.itemPool.count, 2)
    }
    
    func testUserLockTransaction_otherUserHasNotLocked_userIdAddedAndStateIsUnchanged() {
        let transaction = BarterMateTransactionTest.createInitiatedTransactionTwo()
        
        transaction.userLockTransaction(user: BarterMateTransactionTest.alice)
        
        XCTAssertTrue(transaction.hasLockedOffer.contains(BarterMateTransactionTest.alice.id))
        
        XCTAssertEqual(transaction.state, TransactionState.INITIATED)
    }
    
    func testUserLockTransaction_allUserLocked_userIdAddedAndStateChangeToItemLocked() {
        let transaction = BarterMateTransactionTest.createInitiatedTransactionTwo()
        
        transaction.userLockTransaction(user: BarterMateTransactionTest.alice)
        transaction.userLockTransaction(user: BarterMateTransactionTest.bob)
        
        XCTAssertTrue(transaction.hasLockedOffer.contains(BarterMateTransactionTest.alice.id))
        XCTAssertTrue(transaction.hasLockedOffer.contains(BarterMateTransactionTest.bob.id))
        
        XCTAssertEqual(transaction.state, TransactionState.ITEMLOCKED)
    }
    
    func testUserLockTransaction_stateIsNotInitiated_doNothing() {
        let transaction = BarterMateTransactionTest.createLockedTransaction()
        
        transaction.userLockTransaction(user: BarterMateTransactionTest.alice)
        
        XCTAssertEqual(transaction.hasLockedOffer.count, 2)
    }
    
    func testUserCompleteBarter_otherUserHasNotCompleted_userIdAddedAndStateIsUnchanged() {
        let transaction = BarterMateTransactionTest.createLockedTransaction()
        
        transaction.userCompleteBarter(user: BarterMateTransactionTest.alice)
        
        XCTAssertTrue(transaction.hasCompletedBarter.contains(BarterMateTransactionTest.alice.id))
        
        XCTAssertEqual(transaction.state, TransactionState.ITEMLOCKED)
    }
    
    func testUserCompleteBarter_allUserCompletedBarter_userIdAddedAndStateChangeToCompleted() {
        let transaction = BarterMateTransactionTest.createLockedTransaction()
        
        transaction.userCompleteBarter(user: BarterMateTransactionTest.alice)
        transaction.userCompleteBarter(user: BarterMateTransactionTest.bob)
        
        XCTAssertTrue(transaction.hasCompletedBarter.contains(BarterMateTransactionTest.alice.id))
        
        XCTAssertTrue(transaction.hasCompletedBarter.contains(BarterMateTransactionTest.bob.id))
        
        XCTAssertEqual(transaction.state, TransactionState.COMPLETED)
    }
    
    func testUserCompleteBarter_stateIsNotItemLocked_doNothing() {
        let transaction = BarterMateTransactionTest.createInitiatedTransactionTwo()
        
        transaction.userCompleteBarter(user: BarterMateTransactionTest.alice)
        
        XCTAssertTrue(transaction.hasCompletedBarter.isEmpty)
    }
}
