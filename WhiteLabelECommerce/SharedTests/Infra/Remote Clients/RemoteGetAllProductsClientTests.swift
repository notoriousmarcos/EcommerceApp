//
//  RemoteGetAllProductsClientTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetAllProductsClientTests: XCTestCase {
    private lazy var httpClient = MockHTTPClient()
    private lazy var sut = RemoteGetAllProductsClient(httpClient: httpClient)

    func testRemoteGetAllProductsClient_dispatch_ShouldSuccessWithNoProducts() {
        // Arrange
        httpClient.result = "[]".data(using: .utf8)
        // Act
        sut.dispatch { result in
            if case let .success(products) = result {
                XCTAssertEqual(products, [])
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteGetAllProductsClient_dispatch_ShouldSuccessWithTwoProducts() {
        // Assert
        let expectedProducts = Mocks.products
        httpClient.result = Mocks.productsData

        // Act
        sut.dispatch { result in
            if case let .success(products) = result {
                XCTAssertEqual(products, expectedProducts)
            } else {
                XCTFail("Should be succeed.")
            }
        }
    }

    func testRemoteGetAllProductsClient_dispatch_ShouldReceiveAParseError() {
        // Assert
        httpClient.result = Data()

        // Act
        sut.dispatch { result in
            if case let .failure(error) = result,
               case let .errorOnParsing(error) = error {
                XCTAssert(error is DecodingError)
            } else {
                XCTFail("Should be Failed.")
            }
        }
    }

    func testRemoteGetAllProductsClient_dispatch_ShouldReceiveAnHTTPError() {
        // Assert
        httpClient.error = .unauthorized

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
