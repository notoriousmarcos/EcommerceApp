//
//  ProductTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import XCTest
@testable import WhiteLabelECommerce

class ProductTests: XCTestCase {
    func testProduct_init_ShouldRetainProperties() {
        // Arrange
        let sut = Product(
            id: 1,
            title: "Product",
            price: 10.0,
            category: "men's clothing",
            description: "Product description",
            imageURL: "https:imageurl"
        )

       // Assert
        XCTAssertEqual(sut.id, 1)
        XCTAssertEqual(sut.title, "Product")
        XCTAssertEqual(sut.price, 10.0)
        XCTAssertEqual(sut.category, "men's clothing")
        XCTAssertEqual(sut.description, "Product description")
        XCTAssertEqual(sut.imageURL, "https:imageurl")
    }
}
