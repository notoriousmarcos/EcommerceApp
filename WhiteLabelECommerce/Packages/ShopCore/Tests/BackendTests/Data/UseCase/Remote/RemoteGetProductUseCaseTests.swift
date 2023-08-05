//
//  RemoteGetProductUseCaseTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import ShopCore
import XCTest

class RemoteGetProductUseCaseTests: XCTestCase {
    private let mockClient = MockClients()

    func testRemoteGetProductUseCase_executeWithSuccess_ShouldReturnProduct() {
        // Arrange
        mockClient.result = .success(Mocks.product)
        let sut = RemoteGetProductUseCase(client: mockClient)

        // When
        sut.execute(id: 1) { result in
            if case let .success(product) = result {
                // Then
                XCTAssertEqual(product, Mocks.product)
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testRemoteGetProductUseCase_executeWithFailure_ShouldReturnError() {
        // Arrange
        mockClient.result = .failure(.requestError(error: .badRequest))
        let sut = RemoteGetProductUseCase(client: mockClient)

        // When
        sut.execute(id: 1) { result in
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
