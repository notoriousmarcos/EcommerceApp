//
//  CartServiceTests.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import Backend
import Combine
import Mock
@testable import ProductsFeature
import XCTest

final class CartServiceTests: XCTestCase {
  private var mockAddProductUseCase = MockAddProductUseCase()

  func testAddToCartShouldCallAddProductHandler() {
    // Arrange
    let sut = DefaultCartService { product in
      // Assert
      XCTAssertEqual(product, Mocks.product)
    }

    // Act
    sut.addToCart(Mocks.products.first!)
  }

  private class MockAddProductUseCase: AddProductToCartUseCase {
    /// This response will be used to mock the response when fetch is called.
    var response: Result<Cart, DomainError>?

    func execute(
      _ product: Product,
      toCart cart: Cart,
      completion: @escaping CompletionHandler
    ) {
      guard let response = response else { return completion(.failure(.unknown(error: nil))) }
      completion(response)
    }
  }
}
