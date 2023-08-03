//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Foundation

final class ProductViewModel: ObservableObject {
  @Published private(set) var product: ProductViewItem
  private let addToCartAction: ((ProductViewItem) -> Void)?

  init(product: ProductViewItem, addToCartAction: ((ProductViewItem) -> Void)? = nil) {
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
