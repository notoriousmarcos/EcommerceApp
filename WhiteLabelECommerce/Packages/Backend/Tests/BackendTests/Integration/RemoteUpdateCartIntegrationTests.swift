//
//  RemoteUpdateCartIntegrationTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 02/06/22.
//

@testable import Backend
import XCTest

class RemoteUpdateCartIntegrationTests: XCTestCase {
    func testRemoteUpdateCartUseCase_integration_shouldUpdateWithSuccess() {
        // Arrange
        let sut = RemoteUpdateCartUseCase(client: RemoteUpdateCartClient(client: NativeHTTPClient()))
        let expectation = expectation(description: "Wait response to update cart.")

        // Act
        sut.execute(
            cart: Cart(id: 1, userId: 1, date: Date(), products: [CartItem(productId: 1, quantity: 1)])
        ) { result in
            // Assert
            if case let .success(cart) = result {
                XCTAssertEqual(cart.products.count, 1)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}
