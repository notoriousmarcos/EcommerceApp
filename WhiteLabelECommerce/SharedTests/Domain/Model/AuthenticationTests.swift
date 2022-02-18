//
//  AuthenticationTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import XCTest

struct Authentication {
    let token: String
}

class AuthenticationTests: XCTestCase {

    func testAuthentication_init_ShouldRetainProperties() {
        // Arrange
        let sut = Authentication(token: "authentication")

        // Assert
        XCTAssertEqual(sut.token, "authentication")
    }
}
