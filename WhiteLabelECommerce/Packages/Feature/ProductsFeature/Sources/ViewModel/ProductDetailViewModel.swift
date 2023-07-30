//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Foundation

final class ProductDetailViewModel: ObservableObject {
  @Published var product: ProductViewItem

  init(product: ProductViewItem) {
    self.product = product
  }
}
