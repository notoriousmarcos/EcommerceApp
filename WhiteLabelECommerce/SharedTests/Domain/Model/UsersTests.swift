//
//  UsersTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import XCTest
@testable import WhiteLabelECommerce

class UsersTests: XCTestCase {
    func testUser_init_ShouldRetainProperties() {
        // Arrange
        let sut = User(
            id: 1,
            email: "a@a",
            username: "username",
            password: "password",
            firstName: "firstname",
            lastName: "lastname",
            address: "address",
            phone: "1111111"
        )

       // Assert
        XCTAssertEqual(sut.id, 1)
        XCTAssertEqual(sut.email, "a@a")
        XCTAssertEqual(sut.username, "username")
        XCTAssertEqual(sut.password, "password")
        XCTAssertEqual(sut.firstName, "firstname")
        XCTAssertEqual(sut.lastName, "lastname")
        XCTAssertEqual(sut.address, "address")
        XCTAssertEqual(sut.phone, "1111111")
    }
}