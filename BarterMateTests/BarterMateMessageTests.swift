//
//  BarterMateMessage.swift
//  BarterMateTests
//
//  Created by mark on 16/4/2023.
//

import XCTest
@testable import BarterMate
class UserFacadeDelegateMock: UserFacadeDelegate {
    var userUpdated = false
    var user: BarterMateUser? = nil
    func update(user: BarterMateUser) {
        userUpdated = true
        self.user = user
    }
}

class UserFacadeMock: UserFacade {
    var delegate: (any UserFacadeDelegate)?

    func getUserById(id: Identifier<BarterMateUser>) {
        DispatchQueue.global().async {
            let user = BarterMateUser(id: id, username: "MockUser")
            self.delegate?.update(user: user)
        }
    }
}

class BarterMateMessageTests: XCTestCase {
    var sut: BarterMateMessage!

    override func setUp() {
        super.setUp()
        sut = BarterMateMessage(sentIn: nil, sentBy: nil, fetchUserClosure: nil, createdAt: Date(), content: "Test message")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFetchUserWithClosure() {
        let userFacadeMock = UserFacadeMock()
        let userDelegateMock = UserFacadeDelegateMock()
        let userId = "123"
        userFacadeMock.delegate = userDelegateMock

        let expectation = XCTestExpectation(description: "Fetch user")

        let fetchUserClosure: ((@escaping (BarterMateUser) -> BarterMateUser) -> Void) = { completion in
            userFacadeMock.getUserById(id: Identifier(value: userId))
            DispatchQueue.main.async {
                expectation.fulfill()
            }
        }
        sut = BarterMateMessage(sentIn: nil, sentBy: nil, fetchUserClosure: fetchUserClosure, createdAt: Date(), content: "Test message")

        XCTAssertNil(sut.sentBy)
        XCTAssertFalse(sut.hasFetchedDetails)

        sut.fetchDetails()

        wait(for: [expectation], timeout: 2.0)

        XCTAssertTrue(sut.hasFetchedDetails)
        XCTAssertTrue(userDelegateMock.userUpdated)
    }

    func testFetchUserWithNoClosure() {
        XCTAssertNil(sut.sentBy)
        XCTAssertFalse(sut.hasFetchedDetails)

        sut.fetchUser()

        XCTAssertNil(sut.sentBy)
        XCTAssertFalse(sut.hasFetchedDetails)
    }
}
