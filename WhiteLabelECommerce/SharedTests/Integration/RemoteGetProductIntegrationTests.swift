//
//  RemoteGetProductIntegrationTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 02/06/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetProductIntegrationTests: XCTestCase {
    func testRemoteGetProductUseCase_integration_shouldAddWithSuccess() {
        // Arrange
        let sut = RemoteGetProductUseCase(client: RemoteGetProductClient(client: NativeHTTPClient()))
        let expectation = expectation(description: "Wait response to get all products.")

        // Act
        sut.execute(id: 1) { result in
            // Assert
            if case let .success(values) = result {
                XCTAssertEqual(values.id, 1)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }
}
