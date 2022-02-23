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

        sut.dispatch(request: urlRequest) { (result: Result<[String: String], HTTPError>) in
            switch result {
                case .success(let response):
                    XCTAssertEqual(response["response"], "value")
                case .failure:
                    XCTFail("Should return a valid data")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func testNativeHTTPClient_makeRequest_ShouldReturnUnknown() {
        // Arrange
        let sut = NativeHTTPClient(session: session)
        let invalidJSONData = "{\"response\": \"value\"".data(using: .utf8)!
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), invalidJSONData, nil)
        }

        sut.dispatch(request: urlRequest) { (result: Result<[String: String], HTTPError>) in
            switch result {
                case .success:
                    XCTFail("Should return an error")
                case .failure(let error):
                    XCTAssertEqual(error, .unknown)
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func testNativeHTTPClient_makeGetRequest_ShouldReturnBadRequest() {
        // Arrange
        let sut = NativeHTTPClient(session: session)
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (self.createErrorResponseForRequest(request, code: 400), nil, nil)
        }

        sut.dispatch(request: urlRequest) { (result: Result<[String: String], HTTPError>) in
            switch result {
                case .success:
                    XCTFail("Should return an error")
                case .failure(let error):
                    XCTAssertEqual(error, .badRequest)
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func testNativeHTTPClient_makeGetRequest_ShouldReturnUnauthorized() {
        // Arrange
        let sut = NativeHTTPClient(session: session)
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (self.createErrorResponseForRequest(request, code: 401), nil, nil)
        }

        sut.dispatch(request: urlRequest) { (result: Result<[String: String], HTTPError>) in
            switch result {
                case .success:
                    XCTFail("Should return an error")
                case .failure(let error):
                    XCTAssertEqual(error, .unauthorized)
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func testNativeHTTPClient_makeGetRequest_ShouldReturnForbidden() {
        // Arrange
        let sut = NativeHTTPClient(session: session)
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (self.createErrorResponseForRequest(request, code: 403), nil, nil)
        }

        sut.dispatch(request: urlRequest) { (result: Result<[String: String], HTTPError>) in
            switch result {
                case .success:
                    XCTFail("Should return an error")
                case .failure(let error):
                    XCTAssertEqual(error, .forbidden)
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func testNativeHTTPClient_makeGetRequest_ShouldReturnNotFound() {
        // Arrange
        let sut = NativeHTTPClient(session: session)
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (self.createErrorResponseForRequest(request, code: 404), nil, nil)
        }

        sut.dispatch(request: urlRequest) { (result: Result<[String: String], HTTPError>) in
            switch result {
                case .success:
                    XCTFail("Should return an error")
                case .failure(let error):
                    XCTAssertEqual(error, .notFound)
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func testNativeHTTPClient_makeGetRequest_ShouldReturnServerError() {
        // Arrange
        let sut = NativeHTTPClient(session: session)
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (self.createErrorResponseForRequest(request, code: 500), nil, nil)
        }

        sut.dispatch(request: urlRequest) { (result: Result<[String: String], HTTPError>) in
            switch result {
                case .success:
                    XCTFail("Should return an error")
                case .failure(let error):
                    XCTAssertEqual(error, .serverError)
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func testNativeHTTPClient_makeInvalidRequest_ShouldReturnUnknown() {
        // Arrange
        let sut = NativeHTTPClient(session: session)
        let validData = Data()
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (self.createErrorResponseForRequest(request, code: -1), validData, nil)
        }

        sut.dispatch(request: urlRequest) { (result: Result<[String: String], HTTPError>) in
            switch result {
                case .success:
                    XCTFail("Should return an error")
                case .failure(let error):
                    XCTAssertEqual(error, .unknown)
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
