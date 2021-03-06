//
//  ErrorExtensionTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 22/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class ErrorExtensionTests: XCTestCase {
    func testError_createError_ShouldReturnAValidError() {
        let sut = DomainError.createError(withCode: 1, andMessage: "message") as NSError
        XCTAssertEqual(sut.domain, "com.notorious.WhiteLabelECommerce.domain")
        XCTAssertEqual(sut.code, 1)
        XCTAssertEqual(sut.userInfo["message"] as? String, "message")
    }
}
