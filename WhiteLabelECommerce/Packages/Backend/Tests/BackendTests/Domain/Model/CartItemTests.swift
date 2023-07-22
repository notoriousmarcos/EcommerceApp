//
//  CartItemTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

@testable import Backend
import XCTest

class CartItemTests: XCTestCase {
    private var sut = CartItem(productId: 1, quantity: 1)

    func testCartItem_init_ShouldRetainProperties() {
        // Assert
        XCTAssertEqual(sut.productId, 1)
        XCTAssertEqual(sut.quantity, 1)
    }

    func testCartItem_setQuantity_ShouldUpdateQuantity() {
        // Act
        sut.setQuantity(2)

        // Assert
        XCTAssertEqual(sut.quantity, 2)
    }
}
