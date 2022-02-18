//
//  HTTPMethodTests.swift
//  TVMazeAppTests
//
//  Created by marcos.brito on 04/09/21.
//

@testable import WhiteLabelECommerce
import XCTest

class HTTPMethodTests: XCTestCase {
    func testHTTPMethod_initWithRawValue_ShouldReceiveCorrectHTTPMethod() {
        XCTAssertEqual(HTTPMethod(rawValue: "GET"), .get)
        XCTAssertEqual(HTTPMethod(rawValue: "POST"), .post)
        XCTAssertEqual(HTTPMethod(rawValue: "DELETE"), .delete)
        XCTAssertEqual(HTTPMethod(rawValue: "PUT"), .put)
    }
}
