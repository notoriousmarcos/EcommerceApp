//
//  ProductTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

@testable import Backend
import XCTest

class ProductTests: XCTestCase {
  func testProduct_init_ShouldRetainProperties() {
    // Arrange
    let sut = Product(
      id: 1,
      title: "Product",
      price: 10.0,
      category: Category(
        id: 5,
        name: "Others",
        imageURL: "https://placeimg.com/640/480/any?r=0.591926261873231"
      ),
      description: "Product description",
      imagesURL: ["https:imageurl"]
    )

    // Assert
    XCTAssertEqual(sut.id, 1)
    XCTAssertEqual(sut.title, "Product")
    XCTAssertEqual(sut.price, 10.0)
    XCTAssertEqual(sut.category, Category(
      id: 5,
      name: "Others",
      imageURL: "https://placeimg.com/640/480/any?r=0.591926261873231"
    ))
    XCTAssertEqual(sut.description, "Product description")
    XCTAssertEqual(sut.imagesURL, ["https:imageurl"])
  }
}
