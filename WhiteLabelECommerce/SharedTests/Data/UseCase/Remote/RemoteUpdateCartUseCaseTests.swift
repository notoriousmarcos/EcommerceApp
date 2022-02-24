//
//  RemoteUpdateCartUseCaseTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteUpdateCartUseCaseTests: XCTestCase {
    private let mockClient = MockClients()

    func testRemoteUpdateCartUseCase_executeWithSuccess_ShouldReturnCart() {
        // Arrange
        mockClient.result = .success(Mocks.cart)
        let sut = RemoteUpdateCartUseCase(client: mockClient)

        // Act
        sut.execute(cart: Mocks.cart) { result in
            if case let .success(cart) = result {
                // Assert
                XCTAssertNotNil(cart.id)
                XCTAssertEqual(cart.userId, Mocks.cart.userId)
                XCTAssertEqual(cart.date, Mocks.cart.date)
                XCTAssertEqual(cart.products, Mocks.cart.products)
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testRemoteUpdateCartUseCase_executeWithFailure_ShouldReturnError() {
        // Arrange
        mockClient.result = .failure(.requestError(error: .badRequest))
        let sut = RemoteUpdateCartUseCase(client: mockClient)

        // Act
        sut.execute(cart: Mocks.cart) { result in
            if case let .failure(error) = result,
               case let .requestError(error) = error {
                // Assert
                XCTAssertEqual(error, .badRequest)
            } else {
                XCTFail("Should receive an error response")
            }
        }
    }
}
