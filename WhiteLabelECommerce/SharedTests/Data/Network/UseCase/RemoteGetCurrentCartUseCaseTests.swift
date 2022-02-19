//
//  RemoteGetCurrentCartUseCaseTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetCurrentCartUseCaseTests: XCTestCase {
    private let mockClient = MockHTTPClient()

    func testRemoteGetCurrentCartUseCase_executeWithSuccess_ShouldReturnProduct() {
        // Arrange
        mockClient.result = Mocks.cart
        let sut = RemoteGetCurrentCartUseCase(client: mockClient)

        // Act
        sut.execute(id: 1) { result in
            if case let .success(cart) = result {
                // Assert
                XCTAssertEqual(cart, Mocks.cart)
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testRemoteGetCurrentCartUseCase_executeWithFailure_ShouldReturnError() {
        // Arrange
        mockClient.error = HTTPError.badRequest
        let sut = RemoteGetCurrentCartUseCase(client: mockClient)

        // Act
        sut.execute(id: 1) { result in
            if case let .failure(error) = result {
                // Assert
                XCTAssertEqual(error as? HTTPError, .badRequest)
            } else {
                XCTFail("Should receive an error response")
            }
        }
    }
}
