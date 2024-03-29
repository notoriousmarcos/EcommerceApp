//
//  RemoteGetProductIntegrationTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 02/06/22.
//

@testable import ShopCore
import XCTest

class RemoteGetProductIntegrationTests: XCTestCase {
    func testRemoteGetProductUseCase_integration_shouldGetSuccess() {
        // Arrange
        let sut = RemoteGetProductUseCase(client: RemoteGetProductClient(client: NativeHTTPClient()))
        let expectation = expectation(description: "Wait response to get product.")

        // When
        sut.execute(id: 1) { result in
            // Then
            if case let .success(product) = result {
                XCTAssertEqual(product.id, 1)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}
