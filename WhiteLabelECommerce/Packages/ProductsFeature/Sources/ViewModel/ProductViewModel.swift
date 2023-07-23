//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Foundation

class ProductViewModel: ObservableObject {
  @Published var product: ProductViewItem

  private let locale: Locale

  init(
    product: ProductViewItem,
    locale: Locale = .current
  ) {
    self.product = product
    self.locale = locale
  }

  func productPrice() -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = locale.currencyCode

    return formatter.string(for: product.price) ?? ""
  }
}
