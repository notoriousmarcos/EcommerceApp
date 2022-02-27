//
//  RemoteAuthenticationUseCaseTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteAuthenticationUseCaseTests: XCTestCase {
    private let mockClient = MockClients()
    private let authentication = AuthenticationModel(email: "username", password: "password")
    private lazy var sut = RemoteAuthenticationUseCase(client: mockClient)

    func testRemoteAuthenticationUseCase_executeWithSuccess_ShouldReturnToken() {
        // Arrange
        mockClient.result = .success("token")

        // Act
        sut.execute(authenticationModel: authentication) { result in
            if case let .success(token) = result {
                // Assert
                XCTAssertEqual(token, "token")
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testRemoteAuthenticationUseCase_executeWithFailure_ShouldReturnError() {
        // Arrange
        mockClient.result = .failure(.requestError(error: .badRequest))

        // Act
        sut.execute(authenticationModel: authentication) { result in
            if case let .failure(error) = result,
               case let .requestError(error) = error {
                // Assert
                XCTAssertEqual(error, .badRequest)
            } else {
                XCTFail("Should receive an error response")
            }
        }
    }
}
