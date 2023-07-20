//
//  GetProductsRequestTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import Backend
import XCTest

class GetProductsRequestTests: XCTestCase {
  private let sut = GetProductsRequest(offset: 0, limit: 10)

  func testGetProductsRequest_init_ShouldRetainCorrectValues() {
    // Assert
    XCTAssertEqual(sut.path, "/products")
    XCTAssertEqual(sut.method, .get)
    XCTAssertEqual(sut.contentType, "application/json")
    XCTAssertEqual(sut.params?["offset"], "0")
    XCTAssertEqual(sut.params?["limit"], "10")
    XCTAssertNil(sut.body)
    XCTAssertNil(sut.headers)
  }

  func testGetProductsRequest_asURLRequest_ShouldReturnURLRequest() {
    // Act
    let urlRequest = sut.asURLRequest()
    let params: [URLQueryItem]? = URLComponents(string: urlRequest?.url?.absoluteString ?? "")?.queryItems

    // Assert
    XCTAssertNotNil(urlRequest)
    XCTAssertNil(urlRequest?.httpBody)
    XCTAssertEqual(params?.count, 2)
    XCTAssertEqual(params?.first { $0.name == "limit" }?.value, "10")
    XCTAssertEqual(params?.first { $0.name == "offset" }?.value, "0")
    XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
    XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
    XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
  }
}
