//
//  RemoteGetProductsClientTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

@testable import ShopCore
import XCTest

class RemoteGetProductsClientTests: XCTestCase {
  private lazy var httpClient = MockHTTPClient()
  private lazy var sut = RemoteGetProductsClient(client: httpClient)

  func testRemoteGetAllProductsClient_dispatch_ShouldSuccessWithTwoProducts() {
    // Then
    httpClient.responses.append(
      [GetProductsRequest().toString(): (Mocks.products, nil)]
    )

    // When
    sut.dispatch(offset: nil, limit: nil) { result in
      if case let .success(products) = result {
        XCTAssertEqual(products, Mocks.products)
      } else {
        XCTFail("Should be succeed.")
      }
    }
  }

  func testRemoteGetAllProductsClient_dispatch_ShouldReceiveAnHTTPError() {
    // Then
    httpClient.responses.append(
      [GetProductsRequest().toString(): (nil, .requestError(error: .unauthorized))]
    )

    // When
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
