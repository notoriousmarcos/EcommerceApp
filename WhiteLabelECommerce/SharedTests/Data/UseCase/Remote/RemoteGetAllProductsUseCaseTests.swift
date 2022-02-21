//
//  RemoteGetAllProductsUseCaseTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetAllProductsUseCaseTests: XCTestCase {
    private let mockClient = MockHTTPClient()

    func testRemoteGetAllProductsUseCase_executeWithSuccess_ShouldReturnProducts() {
        // Arrange
        mockClient.result = [Mocks.product]
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
        mockClient.error = HTTPError.badRequest
        let sut = RemoteGetAllProductsUseCase(client: mockClient)

        // Act
        sut.execute { result in
            if case let .failure(error) = result {
                // Assert
                XCTAssertEqual(error as? HTTPError, .badRequest)
            } else {
                XCTFail("Should receive an error response")
            }
        }
    }
}
