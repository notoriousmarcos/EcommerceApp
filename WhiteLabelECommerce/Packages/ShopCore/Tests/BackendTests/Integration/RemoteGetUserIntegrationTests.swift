//
//  RemoteGetUserIntegrationTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 02/06/22.
//

@testable import ShopCore
import XCTest

class RemoteGetUserIntegrationTests: XCTestCase {
    func testRemoteGetUserUseCase_integration_shouldGetSuccess() {
        // Arrange
        let sut = RemoteGetUserUseCase(client: RemoteGetUserClient(client: NativeHTTPClient()))
        let expectation = expectation(description: "Wait response to get user.")

        // When
        sut.execute(userId: 1) { result in
            // Then
            if case let .success(user) = result {
                XCTAssertEqual(user.id, 1)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}
