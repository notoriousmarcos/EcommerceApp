//
//  RemoteGetProductClientTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

@testable import ShopCore
import XCTest

class RemoteGetProductClientTests: XCTestCase {
    private lazy var httpClient = MockHTTPClient()
    private lazy var sut = RemoteGetProductClient(client: httpClient)

    func testRemoteGetProductClient_dispatch_ShouldSuccessWithTwoProduct() {
        // Then
        httpClient.responses.append(
            [GetProductRequest(id: 1).toString(): (Mocks.product, nil)]
        )

        // When
        sut.dispatch(productId: 1) { result in
            if case let .success(product) = result {
                XCTAssertEqual(product, Mocks.product)
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteGetProductClient_dispatch_ShouldReceiveAnHTTPError() {
        // Then
        httpClient.responses.append(
            [GetProductRequest(id: 1).toString(): (nil, .requestError(error: .unauthorized))]
        )

        // When
        sut.dispatch(productId: 1) { result in
            if case let .failure(error) = result,
               case let .requestError(error) = error {
                XCTAssertEqual(error, .unauthorized)
            } else {
                XCTFail("Should be Failed.")
            }
        }
    }
}
