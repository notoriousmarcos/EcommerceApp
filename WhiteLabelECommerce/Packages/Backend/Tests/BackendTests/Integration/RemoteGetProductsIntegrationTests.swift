//
//  RemoteGetProductsIntegrationTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 01/05/22.
//

@testable import Backend
import XCTest

class RemoteGetProductsIntegrationTests: XCTestCase {
    func testRemoteGetProductsUseCase_integration_shouldGetSuccess() {
        // Arrange
        let sut = RemoteGetProductsUseCase(client: RemoteGetProductsClient(client: NativeHTTPClient()))
        let expectation = expectation(description: "Wait response to get  products.")

        // When
      sut.execute(offset: 0, limit: 20) { result in
            // Then
            if case let .success(products) = result {
                XCTAssertEqual(products.count, 20)
            }
            expectation.fulfill()
      }

        waitForExpectations(timeout: 5)
    }
}
