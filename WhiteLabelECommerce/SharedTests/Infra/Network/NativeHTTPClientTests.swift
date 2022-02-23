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
    private let urlRequest = URLRequest(url: URL(string: "http://google.com")!)
    private lazy var sut = NativeHTTPClient(session: session)

    func testNativeHTTPClient_init_ShouldRetainProperties() {
        // Arrange
        let sut = NativeHTTPClient(session: session)

        // Assert
        XCTAssertNotNil(sut.session)
    }

    func testNativeHTTPClient_makeRequest_ShouldReturnASuccess() {
        // Arrange
        let sut = NativeHTTPClient(session: session)
        let validData = "{\"response\": \"value\"}".data(using: .utf8)!
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), validData, nil)
        }

        sut.dispatch(request: urlRequest) { (result: Result<Data, HTTPError>) in
            switch result {
                case .success(let data):
                    XCTAssertEqual(data, data)
                case .failure:
                    XCTFail("Should return a valid data")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func testNativeHTTPClient_makeRequest_ShouldValidateMapError() {
        // Arrange
        assertRequestFailing(with: createErrorResponseForRequest(urlRequest, code: 400), expectedError: .badRequest)
        assertRequestFailing(with: createErrorResponseForRequest(urlRequest, code: 401), expectedError: .unauthorized)
        assertRequestFailing(with: createErrorResponseForRequest(urlRequest, code: 403), expectedError: .forbidden)
        assertRequestFailing(with: createErrorResponseForRequest(urlRequest, code: 404), expectedError: .notFound)
        assertRequestFailing(with: createErrorResponseForRequest(urlRequest, code: 500), expectedError: .serverError)
        assertRequestFailing(with: createErrorResponseForRequest(urlRequest, code: -1), expectedError: .unknown)
    }

    private func assertRequestFailing(
        with requestHandlerResponse: URLResponse,
        expectedError error: HTTPError
    ) {
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { _ in
            return (requestHandlerResponse, nil, nil)
        }

        sut.dispatch(request: urlRequest) { (result: Result<Data, HTTPError>) in
            switch result {
                case .success:
                    XCTFail("Should return an error")
                case .failure(let receivedError):
                    XCTAssertEqual(receivedError, error)
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
