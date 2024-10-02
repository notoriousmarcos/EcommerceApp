//
//  CartServiceTests.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import AppState
@testable import CartFeature
import Combine
import Mock
import ShopCore
import XCTest

final class CartServiceTests: XCTestCase {
  private var mockAddProductUseCase = MockAddProductUseCase()
  private var mockContainer = AppContainer(appState: AppState())

  func testAddToCartShouldCallAddProductHandler() {
    // Arrange
    let expectation = expectation(description: "Add Product Handler Should be called with correct data.")
    let sut = DefaultCartService(
      container: mockContainer,
      addProductHandler: { product, cart, completion in
        let cart = Cart(
          id: cart.id,
          userId: cart.userId,
          date: cart.date,
          products: [.init(productId: product.id, quantity: 1)]
        )

        expectation.fulfill()
        completion(.success(cart))
      },
      updateProductHandler: nil,
      removeProductHandler: nil
    )

    // Act
    sut.addProduct(Mocks.product, cart: mockContainer.appState.value.shopCart.cart)
    waitForExpectations(timeout: 1)

    XCTAssertEqual(mockContainer.appState.value.shopCart.cart.products.count, 1)
    XCTAssertEqual(mockContainer.appState.value.shopCart.cart.products.first?.productId, Mocks.product.id)
    XCTAssertEqual(mockContainer.appState.value.shopCart.cart.products.first?.quantity, 1)
  }

  func testUpdateProductShouldCallUpdateProductHandler() {
    // Arrange
    let expectation = expectation(description: "Update Product Handler Should be called with correct data.")
    let sut = DefaultCartService(
      container: mockContainer,
      addProductHandler: nil,
      updateProductHandler: { product, quantity, cart, completion in
        let cart = Cart(
          id: cart.id,
          userId: cart.userId,
          date: cart.date,
          products: [.init(productId: product.id, quantity: quantity)]
        )

        expectation.fulfill()
        completion(.success(cart))
      },
      removeProductHandler: nil
    )

    // Act
    sut.updateProduct(Mocks.product, quantity: 3, cart: mockContainer.appState.value.shopCart.cart)
    waitForExpectations(timeout: 1)

    XCTAssertEqual(mockContainer.appState.value.shopCart.cart.products.count, 1)
    XCTAssertEqual(mockContainer.appState.value.shopCart.cart.products.first?.productId, Mocks.product.id)
    XCTAssertEqual(mockContainer.appState.value.shopCart.cart.products.first?.quantity, 3)
  }

  func testRemoveProductShouldCallRemoveProductHandler() {
    // Arrange
    let appState = AppState()
    appState.shopCart.cart = Cart(
      userId: 1,
      date: .now,
      products: [.init(productId: Mocks.product.id, quantity: 1)]
    )
    mockContainer = AppContainer(appState: appState)
    let expectation = expectation(description: "Remove Product Handler Should be called with correct data.")
    let sut = DefaultCartService(
      container: mockContainer,
      addProductHandler: nil,
      updateProductHandler: nil,
      removeProductHandler: { _, cart, completion in
        let cart = Cart(
          id: cart.id,
          userId: cart.userId,
          date: cart.date,
          products: []
        )

        expectation.fulfill()
        completion(.success(cart))
      }
    )

    // Act
    sut.removeProduct(Mocks.product, cart: mockContainer.appState.value.shopCart.cart)
    waitForExpectations(timeout: 1)

    XCTAssertEqual(mockContainer.appState.value.shopCart.cart.products.count, 0)
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
