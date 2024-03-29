//
//  RemoteGetCurrentCartUseCaseTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

@testable import ShopCore
import XCTest

class RemoteGetCurrentCartUseCaseTests: XCTestCase {
    private let mockClient = MockClients()

    func testRemoteGetCurrentCartUseCase_executeWithSuccess_ShouldReturnProduct() {
        // Arrange
        mockClient.result = .success(Mocks.cart)
        let sut = RemoteGetCurrentCartUseCase(client: mockClient)

        // When
        sut.execute(userId: 1) { result in
            if case let .success(cart) = result {
                // Then
                XCTAssertEqual(cart, Mocks.cart)
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testRemoteGetCurrentCartUseCase_executeWithFailure_ShouldReturnError() {
        // Arrange
        mockClient.result = .failure(.requestError(error: .badRequest))
        let sut = RemoteGetCurrentCartUseCase(client: mockClient)

        // When
        sut.execute(userId: 1) { result in
            if case let .failure(error) = result,
               case let .requestError(error) = error {
                // Then
                XCTAssertEqual(error, .badRequest)
            } else {
                XCTFail("Should receive an error response")
            }
        }
    }
}
