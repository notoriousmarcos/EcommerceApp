//
//  AuthenticationTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class AuthenticationTests: XCTestCase {
    func testAuthentication_init_ShouldRetainProperties() {
        // Arrange
        let sut = Authentication(token: "authentication")

        // Assert
        XCTAssertEqual(sut.token, "authentication")
    }
}
