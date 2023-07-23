//
//  LocalRemoveProductInCartUseCaseTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

@testable import Backend
import XCTest

class LocalRemoveProductInCartUseCaseTests: XCTestCase {
    func testLocalRemoveProductInCartUseCase_removeProduct_ShouldReturnACartWithEmptyProducts() {
        // Arrange
        let sut = LocalRemoveProductInCartUseCase()

        // When
        sut.execute(Mocks.product, inCart: Mocks.cart) { result in
            if case let .success(cart) = result {
                // Then
                XCTAssertEqual(cart.id, Mocks.cart.id)
                XCTAssertEqual(cart.userId, Mocks.cart.userId)
                XCTAssertEqual(cart.date, Mocks.cart.date)
                XCTAssertTrue(cart.products.isEmpty)
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testLocalRemoveProductInCartUseCase_removeProduct_ShouldReturnACartWithOneProduct() {
        // Arrange
        let sut = LocalRemoveProductInCartUseCase()
        let cart = Cart(
            id: Mocks.cart.id,
            userId: Mocks.cart.userId,
            date: Mocks.cart.date,
            products: [
                CartItem(productId: 1, quantity: 1),
                CartItem(productId: 2, quantity: 10)
            ]
        )

        // When
        sut.execute(Mocks.product, inCart: cart) { result in
            if case let .success(cart) = result {
                // Then
                XCTAssertEqual(cart.id, cart.id)
                XCTAssertEqual(cart.userId, cart.userId)
                XCTAssertEqual(cart.date, cart.date)
                XCTAssertEqual(cart.products.count, 1)
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }
}
