//
//  DateExtensionTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

@testable import WhiteLabelECommerce
import XCTest

class DateExtensionTests: XCTestCase {
    func testDate_toString_ShouldReturnAValidString() {
        let sut = Date(timeIntervalSince1970: 122_333)
        XCTAssertEqual(sut.toString(), "1970-01-02")
    }
}
