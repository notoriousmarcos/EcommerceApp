//
//  DoubleExtensionTests.swift
//  
//
//  Created by Marcos Vinicius Brito on 24/07/23.
//

@testable import UI
import XCTest

final class DoubleExtensionTests: XCTestCase {

  /// The device should be in English(US) and United States Region
  func testProductPriceFormatting() {
    // Given
    let locale = Locale(identifier: "en_US") // Use a specific locale for testing (USD in this case)
    XCTAssertEqual(9.99.toCurrencyFormat(locale), "$9.99")
  }

  /// The device should be in English(US) and United States Region
  func testProductPriceFormattingWithDifferentLocale() {
    // Given
    let locale = Locale(identifier: "fr_FR") // Use a different locale for testing (Euro in this case)
    XCTAssertEqual(9.99.toCurrencyFormat(locale), "€9.99")
  }
}
