//
//  RemoteCreateCartIntegrationTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 02/06/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteCreateCartIntegrationTests: XCTestCase {
    func testRemoteCreateCartUseCase_integration_shouldCreateWithSuccess() {
        // Arrange
        let sut = RemoteCreateCartUseCase(client: RemoteCreateCartClient(client: NativeHTTPClient()))
        let expectation = expectation(description: "Wait response to create cart.")

        // Act
        sut.execute(
            cart: Cart(userId: 1, date: Date(), products: [])
        ) { result in
            // Assert
            if case let .success(cart) = result {
                XCTAssertEqual(cart.userId, 1)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}
