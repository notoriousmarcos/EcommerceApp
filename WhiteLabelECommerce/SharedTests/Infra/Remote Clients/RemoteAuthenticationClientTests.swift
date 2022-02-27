//
//  RemoteAuthenticationClientTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteAuthenticationClientTests: XCTestCase {
    private lazy var httpClient = MockHTTPClient()
    private lazy var sut = RemoteAuthenticationClient(client: httpClient)
    private let authenticationModel = AuthenticationModel(email: "email", password: "password")

    func testRemoteAuthenticationClient_dispatch_ShouldSuccessAUser() {
        // Assert
        httpClient.responses.append(
            [AuthenticationRequest(model: authenticationModel).toString(): ("token", nil) ]
        )

        // Act
        sut.dispatch(authentication: authenticationModel) { result in
            if case let .success(token) = result {
                XCTAssertEqual(token, "token")
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteAuthenticationClient_dispatch_ShouldReceiveAnHTTPError() {
        // Assert
        httpClient.responses.append(
            [AuthenticationRequest(model: authenticationModel).toString(): (nil, .requestError(error: .unauthorized))]
        )

        // Act
        sut.dispatch(authentication: authenticationModel) { result in
            if case let .failure(error) = result,
               case let .requestError(error) = error {
                XCTAssertEqual(error, .unauthorized)
            } else {
                XCTFail("Should be Failed.")
            }
        }
    }
}
