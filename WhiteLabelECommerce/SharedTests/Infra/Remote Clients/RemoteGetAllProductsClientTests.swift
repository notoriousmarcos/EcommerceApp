//
//  RemoteGetAllProductsClientTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

import SwiftUI
@testable import WhiteLabelECommerce
import XCTest

class RemoteGetAllProductsClientTests: XCTestCase {
    private lazy var httpClient = MockHTTPClient()
    private lazy var sut = RemoteGetAllProductsClient(client: httpClient)

    func testRemoteGetAllProductsClient_dispatch_ShouldSuccessWithTwoProducts() {
        // Assert
        httpClient.result = Mocks.products

        // Act
        sut.dispatch { result in
            if case let .success(products) = result {
                XCTAssertEqual(products, Mocks.products)
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteGetAllProductsClient_dispatch_ShouldReceiveAnHTTPError() {
        // Assert
        httpClient.error = .requestError(error: .unauthorized)

        // Act
        sut.dispatch { result in
            if case let .failure(error) = result,
               case let .requestError(error) = error {
                XCTAssertEqual(error, .unauthorized)
            } else {
                XCTFail("Should be Failed.")
            }
        }
    }
}
