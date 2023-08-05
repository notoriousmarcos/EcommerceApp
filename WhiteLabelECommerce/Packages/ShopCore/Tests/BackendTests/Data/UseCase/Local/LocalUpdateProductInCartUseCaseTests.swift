//
//  LocalUpdateProductInCartUseCaseTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

@testable import ShopCore
import XCTest

class LocalUpdateProductInCartUseCaseTests: XCTestCase {
  func testLocalUpdateProductInCartUseCase_UpdateProduct_ShouldReturnACartWithEmptyProducts() {
    // Arrange
    let sut = LocalUpdateProductInCartUseCase()

    // When
    sut.execute(Mocks.product, withQuantity: 0, inCart: Mocks.cart) { result in
      if case let .success(cart) = result {
        // Then
        XCTAssertEqual(cart.id, Mocks.cart.id)
        XCTAssertEqual(cart.userId, Mocks.cart.userId)
        XCTAssertEqual(cart.date, Mocks.cart.date)
        XCTAssertTrue(cart.products.isEmpty)
      } else {
        XCTFail("Should receive a valid response")
      }
    }
  }

  func testLocalUpdateProductInCartUseCase_UpdateProduct_ShouldReturnACartWithOneProductAndQuantityTwo() {
    // Arrange
    let sut = LocalUpdateProductInCartUseCase()

    // When
    sut.execute(Mocks.product, withQuantity: 2, inCart: Mocks.cart) { result in
      if case let .success(cart) = result {
        // Then
        XCTAssertEqual(cart.id, cart.id)
        XCTAssertEqual(cart.userId, cart.userId)
        XCTAssertEqual(cart.date, cart.date)
        XCTAssertEqual(cart.products.count, 1)
        XCTAssertEqual(cart.products.first?.quantity, 2)
      } else {
        XCTFail("Should receive a valid response")
      }
    }
  }

  func testLocalUpdateProductInCartUseCase_UpdateProduct_ShouldReturnACartWithOneProductAndQuantityOne() {
    // Arrange
    let sut = LocalUpdateProductInCartUseCase()
    let cart = Cart(
      id: Mocks.cart.id,
      userId: Mocks.cart.userId,
      date: Mocks.cart.date,
      products: [
        CartItem(productId: 1, quantity: 2)
      ]
    )

    // When
    sut.execute(Mocks.product, withQuantity: 1, inCart: cart) { result in
      if case let .success(cart) = result {
        // Then
        XCTAssertEqual(cart.id, cart.id)
        XCTAssertEqual(cart.userId, cart.userId)
        XCTAssertEqual(cart.date, cart.date)
        XCTAssertEqual(cart.products.count, 1)
        XCTAssertEqual(cart.products.first?.quantity, 1)
      } else {
        XCTFail("Should receive a valid response")
      }
    }
  }

  func testLocalUpdateProductInCartUseCase_UpdateInvalidProduct_ShouldReturnSameCart() {
    // Arrange
    let sut = LocalUpdateProductInCartUseCase()
    let product = Mocks.product

    // When
    sut.execute(product, withQuantity: 1, inCart: Mocks.cart) { result in
      if case let .success(cart) = result {
        // Then
        XCTAssertEqual(cart.id, Mocks.cart.id)
        XCTAssertEqual(cart.userId, Mocks.cart.userId)
        XCTAssertEqual(cart.date, Mocks.cart.date)
        XCTAssertEqual(cart.products.count, 1)
        XCTAssertEqual(cart.products.first?.quantity, 1)
        XCTAssertEqual(cart.products.first?.productId, 1)
      } else {
        XCTFail("Should receive a valid response")
      }
    }
  }
}
