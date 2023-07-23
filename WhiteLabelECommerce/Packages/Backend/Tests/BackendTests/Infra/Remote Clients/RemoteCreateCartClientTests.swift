//
//  RemoteCreateCartClientTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

@testable import Backend
import XCTest

class RemoteCreateCartClientTests: XCTestCase {
    private lazy var httpClient = MockHTTPClient()
    private lazy var sut = RemoteCreateCartClient(client: httpClient)

    func testRemoteCreateCartClient_dispatch_ShouldSuccessWithACart() {
        // Then
        httpClient.responses.append(
            [CreateCartRequest(cart: Mocks.cart).toString(): (Mocks.cart, nil)]
        )

        // When
        sut.dispatch(createCart: Mocks.cart) { result in
            if case let .success(cart) = result {
                XCTAssertEqual(cart, Mocks.cart)
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteCreateCartClient_dispatch_ShouldReceiveAnHTTPError() {
        // Then
        httpClient.responses.append(
            [CreateCartRequest(cart: Mocks.cart).toString(): (nil, .requestError(error: .unauthorized))]
        )

        // When
        sut.dispatch(createCart: Mocks.cart) { result in
            if case let .failure(error) = result,
               case let .requestError(error) = error {
                XCTAssertEqual(error, .unauthorized)
            } else {
                XCTFail("Should be Failed.")
            }
        }
    }
}
