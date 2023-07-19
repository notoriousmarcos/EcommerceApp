//
//  ErrorExtensionTests.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 22/02/22.
//

@testable import Backend
import XCTest

class ErrorExtensionTests: XCTestCase {
    func testError_createError_ShouldReturnAValidError() {
        let sut = DomainError.createError(withCode: 1, andMessage: "message") as NSError
        XCTAssertEqual(sut.domain, "com.notorious.Backend.domain")
        XCTAssertEqual(sut.code, 1)
        XCTAssertEqual(sut.userInfo["message"] as? String, "message")
    }
}
