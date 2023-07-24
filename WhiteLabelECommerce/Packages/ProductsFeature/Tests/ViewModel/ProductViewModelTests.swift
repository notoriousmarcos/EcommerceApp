//
//  ProductViewModelTests.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Mock
@testable import ProductsFeature
import XCTest

class ProductViewModelTests: XCTestCase {
  private let product = ProductViewItem(
    id: 1,
    title: "Sample Product",
    price: 9.99,
    category: CategoryItemView(
      id: 1,
      name: "Sample Category",
      imageURL: URL(string: "")
    ),
    description: "This is a sample product",
    imagesURL: []
  )

  /// The device should be in English(USA)
  func testProductPriceFormatting() {
    // Given
    let locale = Locale(identifier: "en_US") // Use a specific locale for testing (USD in this case)
    let sut = ProductViewModel(product: product, locale: locale)

    // When
    let formattedPrice = sut.productPrice()

    // Then
    XCTAssertEqual(formattedPrice, "US$ 9,99")
  }

  /// The device should be in English(USA)
  func testProductPriceFormattingWithDifferentLocale() {
    // Given
    let locale = Locale(identifier: "fr_FR") // Use a different locale for testing (Euro in this case)
    let sut = ProductViewModel(product: product, locale: locale)

    // When
    let formattedPrice = sut.productPrice()

    // Then
    XCTAssertEqual(formattedPrice, "€ 9,99")
  }
}
