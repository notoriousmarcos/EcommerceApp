//
//  CreateCartRequestTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

@testable import Backend
import XCTest

class CreateCartRequestTests: XCTestCase {
    private let sut = CreateCartRequest(cart: Mocks.cart)

    func testCreateCartRequest_init_ShouldRetainCorrectValues() {
        // Assert
        XCTAssertEqual(sut.path, "/carts")
        XCTAssertEqual(sut.method, .post)
        XCTAssertEqual(sut.contentType, "application/json")
        XCTAssertNil(sut.params)
        XCTAssertEqual(sut.body?["id"] as? Int, Mocks.cart.id)
        XCTAssertEqual(sut.body?["userId"] as? Int, Mocks.cart.userId)
        XCTAssertEqual(sut.body?["date"] as? String, Mocks.cart.date.toString())
        let productsJSON = sut.body?["products"] as? [[String: Any]]
        XCTAssertEqual(
            productsJSON?[0]["productId"] as? Int,
            Mocks.cart.products.first?.productId)

        XCTAssertNil(sut.headers)
    }

    func testCreateCartRequest_asURLRequest_ShouldReturnURLRequest() {
        // Act
        let urlRequest = sut.asURLRequest()

        // Assert
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://fakestoreapi.com/carts")
        XCTAssertNotNil(urlRequest?.httpBody)
        XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
    }
}
