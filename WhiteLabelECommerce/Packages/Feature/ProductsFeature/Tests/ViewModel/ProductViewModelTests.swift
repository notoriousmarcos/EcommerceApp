//
//  ProductViewModelTests.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Combine
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
  private var cancellables: Set<AnyCancellable> = []

  func testInstantiateShouldHaveProductPropertyAsPublished() {
    // Given
    let sut = ProductViewModel(product: product)
    let productExpectation = expectation(description: "Expect to receive value of the product.")

    sut.$product.sink { [weak self] currentProduct in
      // Then
      XCTAssertEqual(currentProduct, self?.product)
      productExpectation.fulfill()
    }
    .store(in: &cancellables)

    waitForExpectations(timeout: 1)
  }
}
