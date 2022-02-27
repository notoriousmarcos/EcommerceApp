//
//  RemoteGetUserClientTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetUserClientTests: XCTestCase {
    private lazy var httpClient = MockHTTPClient()
    private lazy var sut = RemoteGetUserClient(client: httpClient)

    func testRemoteGetUserClient_dispatch_ShouldSuccessWithUser() {
        // Assert
        httpClient.responses.append(
            [GetUserRequest(id: 1).toString(): (Mocks.user, nil)]
        )

        // Act
        sut.dispatch(userId: 1) { result in
            if case let .success(user) = result {
                XCTAssertEqual(user, Mocks.user)
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteGetUserClient_dispatch_ShouldReceiveAnHTTPError() {
        // Assert
        httpClient.responses.append(
            [GetUserRequest(id: 1).toString(): (nil, .requestError(error: .unauthorized))]
        )

        // Act
        sut.dispatch(userId: 1) { result in
            if case let .failure(error) = result,
               case let .requestError(error) = error {
                XCTAssertEqual(error, .unauthorized)
            } else {
                XCTFail("Should be Failed.")
            }
        }
    }
}
