//
//  RemoteGetCurrentCartIntegrationTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 02/06/22.
//

@testable import Backend
import XCTest

class RemoteGetCurrentCartIntegrationTests: XCTestCase {
    func testRemoteGetCurrentCartUseCase_integration_shouldGetSuccess() {
        // Arrange
        let sut = RemoteGetCurrentCartUseCase(client: RemoteGetCurrentCartClient(client: NativeHTTPClient()))
        let expectation = expectation(description: "Wait response to get cart.")

        // When
        sut.execute(userId: 1) { result in
            // Then
            if case let .success(cart) = result {
                XCTAssertEqual(cart.userId, 1)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}
