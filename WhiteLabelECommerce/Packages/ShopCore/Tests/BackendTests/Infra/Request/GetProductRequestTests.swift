//
//  GetProductRequestTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import ShopCore
import XCTest

class GetProductRequestTests: XCTestCase {
    func testGetProductRequest_init_ShouldRetainCorrectValues() {
        // Arrange
        let sut = GetProductRequest(id: 1)

        // Then
        XCTAssertEqual(sut.path, "/products/1")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.contentType, "application/json")
        XCTAssertNil(sut.params)
        XCTAssertNil(sut.body)
        XCTAssertNil(sut.headers)
    }

    func testGetProductRequest_asURLRequest_ShouldReturnURLRequest() {
        // Arrange
        let sut = GetProductRequest(id: 1)

        // When
        let urlRequest = sut.asURLRequest()

        // Then
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://api.escuelajs.co/api/v1/products/1")
        XCTAssertNil(urlRequest?.httpBody)
        XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
    }
}
