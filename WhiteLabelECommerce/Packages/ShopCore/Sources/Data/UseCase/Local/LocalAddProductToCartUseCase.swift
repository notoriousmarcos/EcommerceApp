//
//  LocalAddProductToCartUseCase.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

struct LocalAddProductToCartUseCase: AddProductToCartUseCase {
  func execute(_ product: Product, toCart cart: Cart, completion: @escaping CompletionHandler) {
    var products = cart.products
    guard let itemIndex = products.firstIndex(where: { $0.productId == product.id }) else {
      let cartItem = CartItem(productId: product.id, quantity: 1)
      completion(
        .success(
          Cart(
            id: cart.id,
            userId: cart.userId,
            date: cart.date,
            products: cart.products + [cartItem]
          )
        )
      )
      return
    }
    products[itemIndex].setQuantity(products[itemIndex].quantity + 1)

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
