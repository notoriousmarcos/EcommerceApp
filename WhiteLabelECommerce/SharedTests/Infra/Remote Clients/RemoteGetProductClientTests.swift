//
//  RemoteGetProductClientTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetProductClientTests: XCTestCase {
    private lazy var httpClient = MockHTTPClient()
    private lazy var sut = RemoteGetProductClient(client: httpClient)

    func testRemoteGetProductClient_dispatch_ShouldSuccessWithTwoProducts() {
        // Assert
        httpClient.result = Mocks.product

        // Act
        sut.dispatch(productId: 1) { result in
            if case let .success(products) = result {
                XCTAssertEqual(products, Mocks.product)
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteGetProductClient_dispatch_ShouldReceiveAnHTTPError() {
        // Assert
        httpClient.error = .requestError(error: .unauthorized)

        // Act
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
