//
//  AuthenticationRequestTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class AuthenticationRequestTests: XCTestCase {
    private let sut = AuthenticationRequest(model: AuthenticationModel(email: "email", password: "password"))

    func testAuthenticationRequest_init_ShouldRetainCorrectValues() {
        // Assert
        XCTAssertEqual(sut.baseURL, "https://fakestoreapi.com/auth/login")
        XCTAssertEqual(sut.method, .post)
        XCTAssertEqual(sut.contentType, "application/json")
        XCTAssertNil(sut.params)
        XCTAssertEqual(sut.body?["email"] as? String, "email")
        XCTAssertEqual(sut.body?["password"] as? String, "password")
        XCTAssertNil(sut.headers)
    }

    func testAuthenticationRequest_asURLRequest_ShouldReturnURLRequest() {
        // Act
        let urlRequest = sut.asURLRequest()

        // Assert
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://fakestoreapi.com/auth/login")
        XCTAssertNotNil(urlRequest?.httpBody)
        XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
    }
}
