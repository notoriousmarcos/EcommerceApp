//
//  LocalRemoveProductInCartUseCase.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

public struct LocalRemoveProductInCartUseCase: RemoveProductInCartUseCase {

  public init() { }
  
  public func execute(_ product: Product, inCart cart: Cart, completion: @escaping CompletionHandler) {
    var products = cart.products
    products.removeAll(where: { $0.productId == product.id })
    completion(
      .success(
        Cart(
          id: cart.id,
          userId: cart.userId,
          date: cart.date,
          products: products
        )
      )
    )
  }
}
