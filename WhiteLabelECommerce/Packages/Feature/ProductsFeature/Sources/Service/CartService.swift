//
//  CartService.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import Backend
import Foundation

public protocol CartService {
  func addToCart(_ product: Product)
}

public class DefaultCartService: CartService {
  let addProductHandler: ((Product) -> Void)?

  public init(addProductHandler: ((Product) -> Void)?) {
    self.addProductHandler = addProductHandler
  }

  public func addToCart(_ product: Product) {
    addProductHandler?(product)
  }
}
