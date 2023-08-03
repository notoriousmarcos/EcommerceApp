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
  private var cancellables: Set<AnyCancellable> = []

  func testInstantiateShouldHaveProductPropertyAsPublished() {
    // Given
    let sut = ProductViewModel(product: Mocks.product)
    let productExpectation = expectation(description: "Expect to receive value of the product.")

    sut.$product.sink { currentProduct in
      // Then
      XCTAssertEqual(currentProduct, Mocks.product)
      productExpectation.fulfill()
    }
    .store(in: &cancellables)

    waitForExpectations(timeout: 1)
  }
}
