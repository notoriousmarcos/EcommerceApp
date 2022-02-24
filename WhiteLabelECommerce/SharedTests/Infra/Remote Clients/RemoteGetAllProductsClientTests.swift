//
//  RemoteGetAllProductsClientTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RemoteGetAllProductsClientTests: XCTestCase {
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()
    private lazy var httpClient = NativeHTTPClient(session: session)
    private lazy var sut = RemoteGetAllProductsClient(httpClient: httpClient)

    func testRemoteGetAllProductsClient_dispatch_ShouldSuccessWithNoProducts() {
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
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), Mocks.productsData, nil)
        }

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
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), Data(), nil)
        }

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
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 401,
                                           httpVersion: nil,
                                           headerFields: request.allHTTPHeaderFields)!
            return (response, nil, nil)
        }

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
