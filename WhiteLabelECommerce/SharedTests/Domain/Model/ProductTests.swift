//
//  ProductTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import XCTest

struct Product {

    // MARK: - Properties
    let id: Int
    let title: String
    let price: Double
    let category: String
    let description: String
    let imageURL: String

    // MARK: - Init
    init(
    id: Int,
    title: String,
    price: Double,
    category: String,
    description: String,
    image: String
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.category = category
        self.description = description
        self.imageURL = image
    }
}

class ProductTests: XCTestCase {
    func testProduct_init_ShouldRetainProperties() {
        // Arrange
        let sut = Product(
            id: 1,
            title: "Product",
            price: 10.0,
            category: "men's clothing",
            description: "Product description",
            image: "https:imageurl"
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
