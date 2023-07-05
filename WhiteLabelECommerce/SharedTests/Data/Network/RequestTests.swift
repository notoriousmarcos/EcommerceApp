//
//  RequestTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class RequestTests: XCTestCase {
    func testRequest_asURLRequestWithAllProperties_ShouldReturnAValidURLRequest() {
        // Arrange
        let sut = MockRequest(params: ["AnyParam": "param"], body: ["AnyBody": "body"],
                              headers: ["AnyHeader": "header"])

        // Act
        let urlRequest = sut.asURLRequest()

        // Assert
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://fakestoreapi.com?AnyParam=param")
        XCTAssertNotNil(urlRequest?.httpBody)
        XCTAssertNotNil(urlRequest?.allHTTPHeaderFields)
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["AnyHeader"], "header")
    }

    func testRequest_asURLRequestWithoutHeaderAndBody_ShouldReturnAValidURLRequest() {
        // Arrange
        let sut = MockRequest(params: nil, body: nil, headers: nil)

        // Act
        let urlRequest = sut.asURLRequest()

        // Assert
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://fakestoreapi.com")
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
    let params: [String: Any]?
    let body: [String: Any]?
    let headers: [String: String]?
}
