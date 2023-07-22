//
//  RemoteGetProductsClientTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

@testable import Backend
import XCTest

class RemoteGetProductsClientTests: XCTestCase {
  private lazy var httpClient = MockHTTPClient()
  private lazy var sut = RemoteGetProductsClient(client: httpClient)

  func testRemoteGetAllProductsClient_dispatch_ShouldSuccessWithTwoProducts() {
    // Assert
    httpClient.responses.append(
      [GetProductsRequest().toString(): (Mocks.products, nil)]
    )

    // Act
    sut.dispatch(offset: nil, limit: nil) { result in
      if case let .success(products) = result {
        XCTAssertEqual(products, Mocks.products)
      } else {
        XCTFail("Should be succeed.")
      }
    }
  }

  func testRemoteGetAllProductsClient_dispatch_ShouldReceiveAnHTTPError() {
    // Assert
    httpClient.responses.append(
      [GetProductsRequest().toString(): (nil, .requestError(error: .unauthorized))]
    )

    // Act
    sut.dispatch(offset: nil, limit: nil) { result in
      if case let .failure(error) = result,
         case let .requestError(error) = error {
        XCTAssertEqual(error, .unauthorized)
      } else {
        XCTFail("Should be Failed.")
      }
    }
  }
}