//
//  CartService.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import AppState
import Combine
import Foundation
import ShopCore

public protocol CartService {
  var container: AppContainer { get }

  func addProduct(_ product: Product, cart: Cart)
  func updateProduct(_ product: Product, quantity: Int, cart: Cart)
  func removeProduct(_ product: Product, cart: Cart)
}

public class DefaultCartService: CartService {
  public let container: AppContainer
  let addProductHandler: ((Product, Cart, @escaping AddProductToCartUseCase.CompletionHandler) -> Void)?
  let updateProductHandler: ((Product, Int, Cart, @escaping AddProductToCartUseCase.CompletionHandler) -> Void)?
  let removeProductHandler: ((Product, Cart, @escaping AddProductToCartUseCase.CompletionHandler) -> Void)?

  public init(
    container: AppContainer,
    addProductHandler: ((Product, Cart, @escaping AddProductToCartUseCase.CompletionHandler) -> Void)?,
    updateProductHandler: ((Product, Int, Cart, @escaping AddProductToCartUseCase.CompletionHandler) -> Void)?,
    removeProductHandler: ((Product, Cart, @escaping AddProductToCartUseCase.CompletionHandler) -> Void)?
  ) {
    self.container = container
    self.addProductHandler = addProductHandler
    self.updateProductHandler = updateProductHandler
    self.removeProductHandler = removeProductHandler
  }

  public func addProduct(_ product: Product, cart: Cart) {
    addProductHandler?(product, cart, updateCartOnAppState)
  }

  public func updateProduct(_ product: Product, quantity: Int, cart: Cart) {
    updateProductHandler?(product, quantity, cart, updateCartOnAppState)
  }

  public func removeProduct(_ product: Product, cart: Cart) {
    removeProductHandler?(product, cart, updateCartOnAppState)
  }

  private func updateCartOnAppState(_ result: Result<Cart, DomainError>) {
    if case let .success(cart) = result {
      container.appState.bulkUpdate { appState in
        appState.shopCart.cart = cart
      }
    }
  }

  deinit {
  }
}
