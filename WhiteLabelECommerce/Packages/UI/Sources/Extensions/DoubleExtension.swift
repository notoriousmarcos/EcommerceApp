//
//  DoubleExtension.swift
//  
//
//  Created by Marcos Vinicius Brito on 24/07/23.
//

import Foundation

public extension Double {
  func toCurrencyFormat(_ locale: Locale = .current) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = locale.currencyCode

    return formatter.string(for: self) ?? ""
  }
}
