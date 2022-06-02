//
//  RemoteGetAllProductsIntegrationTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 01/05/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetAllProductsIntegrationTests: XCTestCase {
    func testRemoteGetAllProductsUseCase_integration_shouldAddWithSuccess() {
        // Arrange
        let sut = RemoteGetAllProductsUseCase(client: RemoteGetAllProductsClient(client: NativeHTTPClient()))
        let expectation = expectation(description: "Wait response to get all products.")

        // Act
        sut.execute { result in
            // Assert
            if case let .success(values) = result {
                XCTAssertEqual(values.count, 20)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }
}
