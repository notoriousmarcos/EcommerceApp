//
//  RemoteGetAllProductsUseCaseTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetAllProductsUseCaseTests: XCTestCase {
    private let mockClient = MockClients()

    func testRemoteGetAllProductsUseCase_executeWithSuccess_ShouldReturnProducts() {
        // Arrange
        mockClient.result = .success([Mocks.product])
        let sut = RemoteGetAllProductsUseCase(client: mockClient)

        // Act
        sut.execute { result in
            if case let .success(products) = result {
                // Assert
                XCTAssertEqual(products, [Mocks.product])
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testRemoteGetAllProductsUseCase_executeWithFailure_ShouldReturnError() {
        // Arrange
        mockClient.result = .failure(.requestError(error: .badRequest))
        let sut = RemoteGetAllProductsUseCase(client: mockClient)

        // Act
        sut.execute { result in
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
