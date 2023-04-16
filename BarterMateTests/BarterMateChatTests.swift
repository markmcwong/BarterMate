//
//  BarterMateChatTests.swift
//  BarterMateTests
//
//  Created by mark on 16/4/2023.
//

import XCTest
@testable import BarterMate

class BarterMateChatTests: XCTestCase {
    func testInit_returnChatWithCorrectDetails() {
        let chatId = Identifier<BarterMateChat>(value: "1")
        let chatName = "testChat"
        let messages = [BarterMateMessage]()
        let users = [BarterMateUser]()
        let chat = BarterMateChat(id: chatId, name: chatName, messages: messages, users: users)
        
        XCTAssertEqual(chat.id, chatId)
        XCTAssertEqual(chat.name, chatName)
        XCTAssertEqual(chat.messages, messages)
        XCTAssertEqual(chat.users, users)
        XCTAssertNil(chat.fetchMessagesClosure)
        XCTAssertNil(chat.fetchUsersClosure)
        XCTAssertFalse(chat.hasFetchedDetails)
    }
    
    func testFetchMessages_setMessagesCorrectly() {
        let chatId = Identifier<BarterMateChat>(value: "1")
        let chatName = "testChat"
        let users = [BarterMateUser]()
        var fetchMessagesCalled = false
        
        let chat = BarterMateChat(id: chatId, name: chatName, messages: nil, users: users, fetchMessagesClosure:  { fetchMessages in
            fetchMessagesCalled = true
        })
        
        chat.fetchMessages()
        XCTAssertTrue(fetchMessagesCalled)
    }
    
    func testFetchUsers_setUsersCorrectly() {
        let chatId = Identifier<BarterMateChat>(value: "1")
        let chatName = "testChat"
        let messages = [BarterMateMessage]()
        var fetchUsersCalled = false
        
        let chat = BarterMateChat(id: chatId, name: chatName, messages: messages, users: nil, fetchUsersClosure:  { fetchUsers in
            fetchUsersCalled = true
        })
        
        chat.fetchUsers()
        XCTAssertTrue(fetchUsersCalled)
    }
    
    func testFetchDetails_callsFetchMessagesAndFetchUsers() {
        let chatId = Identifier<BarterMateChat>(value: "1")
        let chatName = "testChat"
        var fetchMessagesCalled = false
        var fetchUsersCalled = false
        
        let chat = BarterMateChat(id: chatId, name: chatName, messages: nil, users: nil) { fetchMessages in
            fetchMessagesCalled = true
        } fetchUsersClosure: { fetchUsers in
            fetchUsersCalled = true
        }
        
        chat.fetchDetails()
        
        XCTAssertTrue(fetchMessagesCalled)
        XCTAssertTrue(fetchUsersCalled)
        XCTAssertTrue(chat.hasFetchedDetails)
    }
}
