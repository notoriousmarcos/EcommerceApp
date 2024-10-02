//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Foundation
import ShopCore

final class ProductViewModel: ObservableObject {
  @Published private(set) var product: Product
  private let addToCartAction: ((Product) -> Void)?

  init(product: Product, addToCartAction: ((Product) -> Void)? = nil) {
    self.product = product
    self.addToCartAction = addToCartAction
  }

  func addToCart() {
    addToCartAction?(product)
  }

  deinit {
#if DEBUG
    // print("Deinit \(Self.self)")
#endif
  }
}
