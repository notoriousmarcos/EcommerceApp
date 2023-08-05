//
//  RemoteAuthenticationIntegrationTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 02/06/22.
//

@testable import ShopCore
import XCTest

class RemoteAuthenticationIntegrationTests: XCTestCase {
    func testRemoteAuthenticationUseCase_integration_shouldGetSuccess() {
        // Arrange
        let sut = RemoteAuthenticationUseCase(client: RemoteAuthenticationClient(client: NativeHTTPClient()))
        let expectation = expectation(description: "Wait response to authenticate.")

        // When
        sut.execute(authenticationModel: AuthenticationModel(email: "mor_2314", password: "83r5^_")) { result in
            // Then
            if case let .success(token) = result {
                XCTAssertEqual(token, "")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}
