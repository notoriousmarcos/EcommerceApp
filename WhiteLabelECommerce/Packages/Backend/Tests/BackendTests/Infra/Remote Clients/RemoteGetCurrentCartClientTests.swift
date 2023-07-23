//
//  RemoteGetCurrentCartClientTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

@testable import Backend
import XCTest

class RemoteGetCurrentCartClientTests: XCTestCase {
    private lazy var httpClient = MockHTTPClient()
    private lazy var sut = RemoteGetCurrentCartClient(client: httpClient)

    func testRemoteGetCurrentCartClient_dispatch_ShouldSuccessWithACart() {
        // Then
        httpClient.responses.append(
            [GetCurrentCartRequest(userId: 1).toString(): (Mocks.cart, nil)]
        )

        // When
        sut.dispatch(userId: 1) { result in
            if case let .success(cart) = result {
                XCTAssertEqual(cart, Mocks.cart)
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteGetCurrentCartClient_dispatch_ShouldReceiveAnHTTPError() {
        // Then
        httpClient.responses.append(
            [GetCurrentCartRequest(userId: 1).toString(): (nil, .requestError(error: .unauthorized))]
        )

        // When
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
