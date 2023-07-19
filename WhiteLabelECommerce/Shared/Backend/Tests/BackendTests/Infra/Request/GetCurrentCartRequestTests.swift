//
//  GetCurrentCartRequestTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import Backend
import XCTest

class GetCurrentCartRequestTests: XCTestCase {
    func testGetCurrentCartRequest_init_ShouldRetainCorrectValues() {
        // Arrange
        let sut = GetCurrentCartRequest(userId: 1)

        // Assert
        XCTAssertEqual(sut.path, "/carts/user/1")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.contentType, "application/json")
        XCTAssertNil(sut.params)
        XCTAssertNil(sut.body)
        XCTAssertNil(sut.headers)
    }

    func testGetGetCurrentCartRequest_asURLRequest_ShouldReturnURLRequest() {
        // Arrange
        let sut = GetCurrentCartRequest(userId: 1)

        // Act
        let urlRequest = sut.asURLRequest()

        // Assert
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://fakestoreapi.com/carts/user/1")
        XCTAssertNil(urlRequest?.httpBody)
        XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
    }
}
