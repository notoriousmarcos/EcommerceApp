//
//  ErrorExtensionTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 22/02/22.
//

@testable import ShopCore
import XCTest

class ErrorExtensionTests: XCTestCase {
    func testError_createError_ShouldReturnAValidError() {
        let sut = DomainError.createError(withCode: 1, andMessage: "message") as NSError
        XCTAssertEqual(sut.domain, "com.notorious.ShopCore.domain")
        XCTAssertEqual(sut.code, 1)
        XCTAssertEqual(sut.userInfo["message"] as? String, "message")
    }
}
