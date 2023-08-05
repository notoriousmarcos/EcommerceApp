//
//  RemoteGetProductsUseCaseTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import ShopCore
import XCTest

class RemoteGetProductsUseCaseTests: XCTestCase {
    private let mockClient = MockClients()

    func testRemoteGetProductsUseCase_executeWithSuccess_ShouldReturnProducts() {
        // Arrange
        mockClient.result = .success([Mocks.product])
        let sut = RemoteGetProductsUseCase(client: mockClient)

        // When
        sut.execute { result in
            if case let .success(products) = result {
                // Then
                XCTAssertEqual(products, [Mocks.product])
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testRemoteGetProductsUseCase_executeWithFailure_ShouldReturnError() {
        // Arrange
        mockClient.result = .failure(.requestError(error: .badRequest))
        let sut = RemoteGetProductsUseCase(client: mockClient)

        // When
        sut.execute { result in
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
