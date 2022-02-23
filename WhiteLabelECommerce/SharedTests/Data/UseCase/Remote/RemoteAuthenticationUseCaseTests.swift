//
//  RemoteAuthenticationUseCaseTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteAuthenticationUseCaseTests: XCTestCase {
    private let mockClient = MockHTTPClient()
    private let authentication = AuthenticationModel(email: "username", password: "password")
    private lazy var sut = RemoteAuthenticationUseCase(client: mockClient)

    func testRemoteAuthenticationUseCase_executeWithSuccess_ShouldReturnUser() {
        // Arrange
        mockClient.result = Mocks.user

        // Act
        sut.execute(authenticationModel: authentication) { result in
            if case let .success(user) = result {
                // Assert
                XCTAssertEqual(user.id, 1)
                XCTAssertEqual(user.email, "a@a")
                XCTAssertEqual(user.username, "username")
                XCTAssertEqual(user.auth?.token, "token")
                XCTAssertEqual(user.firstName, "firstname")
                XCTAssertEqual(user.lastName, "lastname")
                XCTAssertEqual(user.address, "address")
                XCTAssertEqual(user.phone, "1111111")
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testRemoteAuthenticationUseCase_executeWithFailure_ShouldReturnError() {
        // Arrange
        mockClient.error = HTTPError.badRequest

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
