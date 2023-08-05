//
//  StringExtensionTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 22/02/22.
//

@testable import ShopCore
import XCTest

class StringExtensionTests: XCTestCase {
    func testString_createDate_ShouldReturnAValidDate() {
        let sut = "1970-01-01".toDate()
        XCTAssertEqual(sut, Date(timeIntervalSince1970: 0))
    }

    func testString_createDate_ShouldReturnNil() {
        let sut = "1970-01-".toDate()
        XCTAssertNil(sut)
    }
}
