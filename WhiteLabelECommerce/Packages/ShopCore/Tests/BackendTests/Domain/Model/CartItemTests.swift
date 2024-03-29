//
//  CartItemTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

@testable import ShopCore
import XCTest

class CartItemTests: XCTestCase {
    private var sut = CartItem(productId: 1, quantity: 1)

    func testCartItem_init_ShouldRetainProperties() {
        // Then
        XCTAssertEqual(sut.productId, 1)
        XCTAssertEqual(sut.quantity, 1)
    }

    func testCartItem_setQuantity_ShouldUpdateQuantity() {
        // When
        sut.setQuantity(2)

        // Then
        XCTAssertEqual(sut.quantity, 2)
    }
}
