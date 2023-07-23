//
//  AuthenticationTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import Backend
import XCTest

class AuthenticationTests: XCTestCase {
    func testAuthentication_init_ShouldRetainProperties() {
        // Arrange
        let sut = Authentication(token: "authentication")

        // Then
        XCTAssertEqual(sut.token, "authentication")
    }
}
