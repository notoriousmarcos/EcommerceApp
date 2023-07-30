//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Foundation

final class ProductViewModel: ObservableObject {
  @Published private(set) var product: ProductViewItem

  init(product: ProductViewItem) {
    self.product = product
  }

  deinit {
#if DEBUG
    print("Deinit \(Self.self)")
#endif
  }
}
