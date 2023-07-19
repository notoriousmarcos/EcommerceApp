//
//  LocalAddProductToCartUseCaseTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

@testable import Backend
import XCTest

class LocalAddProductToCartUseCaseTests: XCTestCase {
    func testLocalAddProductToCartUseCase_addProduct_ShouldReturnACartWithOneProduct() {
        // Assert
        let sut = LocalAddProductToCartUseCase()

        // Act
        sut.execute(
            Mocks.product,
            toCart: Cart(
                id: 1,
                userId: 1,
                date: Date(timeIntervalSince1970: 122_333),
                products: []
            )
        ) { result in
            if case let .success(cart) = result {
                // Assert
                XCTAssertNotNil(cart.id)
                XCTAssertEqual(cart.userId, Mocks.cart.userId)
                XCTAssertEqual(cart.date, Mocks.cart.date)
                XCTAssertEqual(cart.products, Mocks.cart.products)
                XCTAssertEqual(cart.products.first?.quantity, 1)
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testLocalAddProductToCartUseCase_addSameProduct_ShouldReturnUpdatedCartWithOneProductAndQuantityTwo() {
        // Assert
        let sut = LocalAddProductToCartUseCase()

        // Act
        sut.execute(Mocks.product, toCart: Mocks.cart) { result in
            if case let .success(cart) = result {
                // Assert
                XCTAssertNotNil(cart.id)
                XCTAssertEqual(cart.userId, Mocks.cart.userId)
                XCTAssertEqual(cart.date, Mocks.cart.date)
                XCTAssertNotEqual(cart.products, Mocks.cart.products)
                XCTAssertEqual(cart.products.first?.productId, Mocks.product.id)
                XCTAssertEqual(cart.products.first?.quantity, 2)
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }
}
