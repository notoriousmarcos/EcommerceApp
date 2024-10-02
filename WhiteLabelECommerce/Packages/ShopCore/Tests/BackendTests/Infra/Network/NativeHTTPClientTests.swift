//
//  NativeHTTPClientTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 23/02/22.
//

import Combine
@testable import ShopCore
import XCTest

class NativeHTTPClientTests: XCTestCase {
  private lazy var session: URLSession = {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: configuration)
  }()
  private var request = StubRequest(path: "")
  private lazy var sut = NativeHTTPClient(session: session)

  override func setUp() {
    super.setUp()
    MockURLProtocol.requestHandler = nil
    super.tearDown()
  }

  override func tearDown() {
    MockURLProtocol.requestHandler = nil
    super.tearDown()
  }

  func testNativeHTTPClient_init_ShouldRetainProperties() {
    // Then
    XCTAssertNotNil(sut.session)
  }

  func testNativeHTTPClient_dispatch_ShouldSuccessWithNoProducts() {
    // Arranged
    request.path = "/testNativeHTTPClient_dispatch_ShouldSuccessWithNoProducts"
    let exp = expectation(description: "Waiting for Request")

    MockURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), "[]".data(using: .utf8), nil)
    }

    // When
    sut.dispatch(request: request) { (result: Result<[Product], DomainError>) in
      if case let .success(products) = result {
        XCTAssertEqual(products, [])
      } else {
        XCTFail("Should be succeed.")
      }
      exp.fulfill()
    }

    wait(for: [exp], timeout: 1)
  }

  func testNativeHTTPClient_dispatch_ShouldSuccessWithTwoProducts() {
    // Arrange
    request.path = "/testNativeHTTPClient_dispatch_ShouldSuccessWithTwoProducts"
    let expectedProducts = Mocks.products
    let validData = Mocks.productsData
    let exp = expectation(description: "Waiting for Request")

    MockURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), validData, nil)
    }

    sut.dispatch(request: request) { (result: Result<[Product], DomainError>) in
      if case let .success(products) = result {
        XCTAssertEqual(products, expectedProducts)
      } else {
        XCTFail("Should be succeed.")
      }
      exp.fulfill()
    }

    wait(for: [exp], timeout: 1)
  }

  func testNativeHTTPClient_dispatch_ShouldReceiveAParseError() {
    // Arranged
    request.path = "/testNativeHTTPClient_dispatch_ShouldReceiveAParseError"
    let exp = expectation(description: "Waiting for Request")

    MockURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), Data(), nil)
    }

    // When
    sut.dispatch(request: request) { (result: Result<[Product], DomainError>) in
      if case let .failure(error) = result,
         case let .errorOnParsing(error) = error {
        XCTAssert(error is DecodingError)
      } else {
        XCTFail("Should be Failed.")
      }
      exp.fulfill()
    }

    wait(for: [exp], timeout: 1)
  }

  func testNativeHTTPClient_dispatch_ShouldReceiveUrlError() {
    // Arranged
    let exp = expectation(description: "Waiting for Request")

    // When
    sut.dispatch(request: StubRequest(path: "/path")) { (result: Result<[Product], DomainError>) in
      if case let .failure(error) = result,
         case let .requestError(error) = error {
        XCTAssertEqual(error, .unknown)
      } else {
        XCTFail("Should be Failed because error: \(result).")
      }
      exp.fulfill()
    }

    wait(for: [exp], timeout: 1)
  }

  func testNativeHTTPClient_makeRequest_ShouldValidateMapError() {
    // Arrange
    assertRequestFailing(
      with: createErrorResponseForRequest(request.asURLRequest()!, code: 400),
      expectedError: .badRequest
    )
    assertRequestFailing(
      with: createErrorResponseForRequest(request.asURLRequest()!, code: 401),
      expectedError: .unauthorized
    )
    assertRequestFailing(
      with: createErrorResponseForRequest(request.asURLRequest()!, code: 403),
      expectedError: .forbidden
    )
    assertRequestFailing(
      with: createErrorResponseForRequest(request.asURLRequest()!, code: 404),
      expectedError: .notFound
    )
    assertRequestFailing(
      with: createErrorResponseForRequest(request.asURLRequest()!, code: 500),
      expectedError: .serverError
    )
    assertRequestFailing(
      with: createErrorResponseForRequest(request.asURLRequest()!, code: -1),
      expectedError: .unknown
    )
  }

  private struct StubRequest: Request {
    var path: String
    var method: HTTPMethod = .get
    var contentType: String = ""
    var params: [String: String]?
    var body: [String: Any]?
    var headers: [String: String]?
  }

  private func assertRequestFailing(
    with requestHandlerResponse: URLResponse,
    expectedError: HTTPError
  ) {
    // Arranged
    request.path = "/\(expectedError.localizedDescription)"
    let exp = expectation(description: "Waiting for Request")

    MockURLProtocol.requestHandler = { _ in
      return (requestHandlerResponse, nil, nil)
    }

    // When
    sut.dispatch(request: request) { (result: Result<[Product], DomainError>) in
      if case let .failure(error) = result,
         case let .requestError(receivedError) = error {
        XCTAssertEqual(receivedError, expectedError)
      } else {
        XCTFail("Should be Failed.")
      }
      exp.fulfill()
    }

    wait(for: [exp], timeout: 1)
  }

  private func createErrorResponseForRequest(_ request: URLRequest, code: Int) -> URLResponse {
    HTTPURLResponse(url: request.url!,
                    statusCode: code,
                    httpVersion: nil,
                    headerFields: request.allHTTPHeaderFields)!
  }
}
