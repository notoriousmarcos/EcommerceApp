//
//  UpdateCartRequestTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class UpdateCartRequestTests: XCTestCase {
    private let sut = UpdateCartRequest(cart: Mocks.cart)

    func testUpdateCartRequest_initWithValidCart_ShouldRetainCorrectValues() {
        // Assert
        XCTAssertEqual(sut?.baseURL, "https://fakestoreapi.com/carts/1")
        XCTAssertEqual(sut?.method, .put)
        XCTAssertEqual(sut?.contentType, "application/json")
        XCTAssertNil(sut?.params)
        XCTAssertEqual(sut?.body?["id"] as? Int, Mocks.cart.id)
        XCTAssertEqual(sut?.body?["userId"] as? Int, Mocks.cart.userId)
        XCTAssertEqual(sut?.body?["date"] as? String, Mocks.cart.date.toString())
        let productsJSON = sut?.body?["products"] as? [[String: Any]]
        XCTAssertEqual(
            productsJSON?[0]["productId"] as? Int,
            Mocks.cart.products.first?.productId)

        XCTAssertNil(sut?.headers)
    }

    func testUpdateCartRequest_initWithInvalidCart_ShouldReturnNil() {
        // Arrange
        let sut = UpdateCartRequest(
            cart: Cart(
                id: nil,
                userId: 1,
                date: Date(timeIntervalSince1970: 122_333),
                products: [Mocks.cartItem]
            )
        )

        // Assert
        XCTAssertNil(sut)
    }

    func testUpdateCartRequest_asURLRequest_ShouldReturnURLRequest() {
        // Act
        let urlRequest = sut?.asURLRequest()

        // Assert
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://fakestoreapi.com/carts/1")
        XCTAssertNotNil(urlRequest?.httpBody)
        XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
    }
}
