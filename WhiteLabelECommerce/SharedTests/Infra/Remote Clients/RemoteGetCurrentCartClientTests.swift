//
//  RemoteGetCurrentCartClientTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetCurrentCartClientTests: XCTestCase {
    private lazy var httpClient = MockHTTPClient()
    private lazy var sut = RemoteGetCurrentCartClient(client: httpClient)

    func testRemoteGetCurrentCartClient_dispatch_ShouldSuccessWithTwoProducts() {
        // Assert
        httpClient.result = Mocks.cart

        // Act
        sut.dispatch(userId: 1) { result in
            if case let .success(cart) = result {
                XCTAssertEqual(cart, Mocks.cart)
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteGetCurrentCartClient_dispatch_ShouldReceiveAnHTTPError() {
        // Assert
        httpClient.error = .requestError(error: .unauthorized)

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
