//
//  RemoteGetUserUseCaseTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetUserUseCaseTests: XCTestCase {
    private let mockClient = MockClients()
    private lazy var sut = RemoteGetUserUseCase(client: mockClient)

    func testRemoteGetUserUseCase_executeWithSuccess_ShouldReturnUser() {
        // Arrange
        mockClient.result = .success(Mocks.user)

        // Act
        sut.execute(userId: 1) { result in
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

    func testRemoteGetUserUseCase_executeWithFailure_ShouldReturnError() {
        // Arrange
        mockClient.result = .failure(.requestError(error: .badRequest))

        // Act
        sut.execute(userId: 1) { result in
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
