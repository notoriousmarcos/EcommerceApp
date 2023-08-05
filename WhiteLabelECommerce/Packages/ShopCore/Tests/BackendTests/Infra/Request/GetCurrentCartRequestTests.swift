//
//  GetCurrentCartRequestTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import ShopCore
import XCTest

class GetCurrentCartRequestTests: XCTestCase {
    func testGetCurrentCartRequest_init_ShouldRetainCorrectValues() {
        // Arrange
        let sut = GetCurrentCartRequest(userId: 1)

        // Then
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

        // When
        let urlRequest = sut.asURLRequest()

        // Then
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://api.escuelajs.co/api/v1/carts/user/1")
        XCTAssertNil(urlRequest?.httpBody)
        XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
    }
}
