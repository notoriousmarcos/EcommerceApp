//
//  NativeHTTPClientTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/02/22.
//

import Combine
@testable import WhiteLabelECommerce
import XCTest

class NativeHTTPClientTests: XCTestCase {
  private lazy var session: URLSession = {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: configuration)
  }()
  private var request = StubRequest(path: "")
  private lazy var sut = NativeHTTPClient(session: session)

  override func tearDown() {
    MockURLProtocol.requestHandler = nil
    super.tearDown()
  }

  func testNativeHTTPClient_init_ShouldRetainProperties() {
    // Arrange
    let sut = NativeHTTPClient(session: session)

    // Assert
    XCTAssertNotNil(sut.session)
  }

  func testNativeHTTPClient_dispatch_ShouldSuccessWithNoProducts() {
    // Arranged
    let exp = expectation(description: "Waiting for Request")

    MockURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), "[]".data(using: .utf8), nil)
    }

    // Act
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
    let sut = NativeHTTPClient(session: session)
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
    let exp = expectation(description: "Waiting for Request")

    MockURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), Data(), nil)
    }

    // Act
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
    let sut = NativeHTTPClient()
    let exp = expectation(description: "Waiting for Request")

    // Act
    sut.dispatch(request: StubRequest(path: "http\\")) { (result: Result<[Product], DomainError>) in
      if case let .failure(error) = result,
         case let .requestError(error) = error {
        XCTAssertEqual(error, .urlError)
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
    var params: [String: Any]?
    var body: [String: Any]?
    var headers: [String: String]?
  }

  private func assertRequestFailing(
    with requestHandlerResponse: URLResponse,
    expectedError: HTTPError
  ) {
    // Arranged
    let exp = expectation(description: "Waiting for Request")

    MockURLProtocol.requestHandler = { _ in
      return (requestHandlerResponse, nil, nil)
    }

    // Act
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
