//
//  CartService.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import Backend
import Combine
import Foundation

public protocol CartService {
  func addProduct(_ product: Product)
  func updateProduct(_ product: Product, quantity: Int)
  func removeProduct(_ product: Product)
}

public class DefaultCartService: CartService {
  let addProductHandler: ((Product) -> Void)?
  let updateProductHandler: ((Product, Int) -> Void)?
  let removeProductHandler: ((Product) -> Void)?

  public init(
    addProductHandler: ((Product) -> Void)?,
    updateProductHandler: ((Product, Int) -> Void)?,
    removeProductHandler: ((Product) -> Void)?
  ) {
    self.addProductHandler = addProductHandler
    self.updateProductHandler = updateProductHandler
    self.removeProductHandler = removeProductHandler
  }

  public func addProduct(_ product: Product) {
    addProductHandler?(product)
  }

  public func updateProduct(_ product: Product, quantity: Int) {
    updateProductHandler?(product, quantity)
  }

  public func removeProduct(_ product: Product) {
    removeProductHandler?(product)
  }
}
