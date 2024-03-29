//
//  CartTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

@testable import ShopCore
import XCTest

class CartTests: XCTestCase {
    func testCart_init_ShouldRetainProperties() {
        // Arrange
        let creationDate = Date()
        let item = CartItem(productId: 1, quantity: 1)

        let sut = Cart(
            id: 1,
            userId: 1,
            date: creationDate,
            products: [item]
        )

       // Then
        XCTAssertEqual(sut.id, 1)
        XCTAssertEqual(sut.userId, 1)
        XCTAssertEqual(sut.date, creationDate)
        XCTAssertEqual(sut.products, [item])
    }
}
