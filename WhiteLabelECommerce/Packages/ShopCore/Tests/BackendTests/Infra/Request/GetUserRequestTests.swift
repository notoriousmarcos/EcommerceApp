//
//  GetUserRequestTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import ShopCore
import XCTest

class GetUserRequestTests: XCTestCase {
    func testGetUserRequest_init_ShouldRetainCorrectValues() {
        // Arrange
        let sut = GetUserRequest(id: 1)

        // Then
        XCTAssertEqual(sut.path, "/users/1")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.contentType, "application/json")
        XCTAssertNil(sut.params)
        XCTAssertNil(sut.body)
        XCTAssertNil(sut.headers)
    }

    func testGetUserRequest_asURLRequest_ShouldReturnURLRequest() {
        // Arrange
        let sut = GetUserRequest(id: 1)

        // When
        let urlRequest = sut.asURLRequest()

        // Then
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://api.escuelajs.co/api/v1/users/1")
        XCTAssertNil(urlRequest?.httpBody)
        XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
    }
}
