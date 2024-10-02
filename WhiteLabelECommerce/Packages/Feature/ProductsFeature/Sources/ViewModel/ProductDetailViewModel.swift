//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Foundation
import ShopCore

final class ProductDetailViewModel: ObservableObject {
  @Published var product: Product

  init(product: Product) {
    self.product = product
  }

  deinit {
#if DEBUG
    // print("Deinit \(Self.self)")
#endif
  }
}
