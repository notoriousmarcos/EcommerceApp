//
//  RemoteGetProductUseCaseTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetProductUseCaseTests: XCTestCase {
    private let mockClient = MockHTTPClient()

    func testRemoteGetProductUseCase_executeWithSuccess_ShouldReturnProduct() {
        // Arrange
        mockClient.result = Mocks.product
        let sut = RemoteGetProductUseCase(client: mockClient)

        // Act
        sut.execute(id: 1) { result in
            if case let .success(product) = result {
                // Assert
                XCTAssertEqual(product, Mocks.product)
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testRemoteGetProductUseCase_executeWithFailure_ShouldReturnError() {
        // Arrange
        mockClient.error = HTTPError.badRequest
        let sut = RemoteGetProductUseCase(client: mockClient)

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
