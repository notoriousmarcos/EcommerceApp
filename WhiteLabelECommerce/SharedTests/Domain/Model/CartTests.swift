//
//  CartTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import XCTest
@testable import WhiteLabelECommerce

class CartTests: XCTestCase {
    func testCart_init_ShouldRetainProperties() {
        // Arrange
        let creationDate = Date()
        let product = Product(
            id: 1,
            title: "Product",
            price: 10.0,
            category: "men's clothing",
            description: "Product description",
            imageURL: "https:imageurl"
        )
        let sut = Cart(
            id: 1,
            userId: 1,
            date: creationDate,
            products: [product]
        )

       // Assert
        XCTAssertEqual(sut.id, 1)
        XCTAssertEqual(sut.userId, 1)
        XCTAssertEqual(sut.date, creationDate)
        XCTAssertEqual(sut.products, [product])
    }
}
