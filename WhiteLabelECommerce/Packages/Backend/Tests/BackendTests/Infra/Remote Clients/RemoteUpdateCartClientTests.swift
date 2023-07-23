//
//  RemoteUpdateCartClientTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

@testable import Backend
import XCTest

class RemoteUpdateCartClientTests: XCTestCase {
    private lazy var httpClient = MockHTTPClient()
    private lazy var sut = RemoteUpdateCartClient(client: httpClient)

    func testRemoteUpdateCartClient_dispatch_ShouldSuccessWithACart() {
        // Then
        httpClient.responses.append(
            [UpdateCartRequest(cart: Mocks.cart)!.toString(): (Mocks.cart, nil)]
        )

        // When
        sut.dispatch(updateCart: Mocks.cart) { result in
            if case let .success(cart) = result {
                XCTAssertEqual(cart, Mocks.cart)
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteUpdateCartClient_dispatch_ShouldReceiveAnHTTPError() {
        // Then
        httpClient.responses.append(
            [UpdateCartRequest(cart: Mocks.cart)!.toString(): (nil, .requestError(error: .unauthorized))]
        )

        // When
        sut.dispatch(updateCart: Mocks.cart) { result in
            if case let .failure(error) = result,
               case let .requestError(error) = error {
                XCTAssertEqual(error, .unauthorized)
            } else {
                XCTFail("Should be Failed.")
            }
        }
    }
}
