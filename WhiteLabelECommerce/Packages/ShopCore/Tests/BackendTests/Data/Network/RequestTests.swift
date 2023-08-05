//
//  RequestTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import ShopCore
import XCTest

class RequestTests: XCTestCase {
  func testRequest_asURLRequestWithAllProperties_ShouldReturnAValidURLRequest() {
    // Arrange
    let sut = MockRequest(params: ["AnyParam": "param"], body: ["AnyBody": "body"],
                          headers: ["AnyHeader": "header"])

    // When
    let urlRequest = sut.asURLRequest()
    let params: [URLQueryItem]? = URLComponents(string: urlRequest?.url?.absoluteString ?? "")?.queryItems

    // Then
    XCTAssertNotNil(urlRequest)
    XCTAssertNotNil(urlRequest?.httpBody)
    XCTAssertEqual(params?.count, 1)
    XCTAssertEqual(params?.first { $0.name == "AnyParam" }?.value, "param")
    XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
    XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
    XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
    XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["AnyHeader"], "header")
  }

  func testRequest_asURLRequestWithoutHeaderAndBody_ShouldReturnAValidURLRequest() {
    // Arrange
    let sut = MockRequest(params: nil, body: nil, headers: nil)

    // When
    let urlRequest = sut.asURLRequest()

    // Then
    XCTAssertNotNil(urlRequest)
    XCTAssertEqual(urlRequest?.url?.absoluteString, "https://api.escuelajs.co/api/v1")
    XCTAssertNil(urlRequest?.httpBody)
    XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
    XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
    XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
  }
}

private struct MockRequest: Request {
  typealias ReturnType = String

  let path: String = ""
  let method: HTTPMethod = .get
  let contentType: String = "application/json"
  let params: [String: String]?
  let body: [String: Any]?
  let headers: [String: String]?
}
