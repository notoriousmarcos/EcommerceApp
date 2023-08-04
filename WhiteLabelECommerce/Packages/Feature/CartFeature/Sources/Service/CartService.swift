//
//  CartService.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import Backend
import Foundation
import Combine

public class CartService {
  let getProductUseCase: GetProductUseCase
  let addProductHandler: ((Product) -> Void)?
  let updateProductHandler: ((Product, Int) -> Void)?
  let removeProductHandler: ((Product) -> Void)?

  public init(
    addProductHandler: ((Product) -> Void)?,
    updateProductHandler: ((Product, Int) -> Void)?,
    removeProductHandler: ((Product) -> Void)?,
    getProductUseCase: GetProductUseCase
  ) {
    self.addProductHandler = addProductHandler
    self.updateProductHandler = updateProductHandler
    self.removeProductHandler = removeProductHandler
    self.getProductUseCase = getProductUseCase
  }

  func getCartItems(_ cart: Cart) -> AnyPublisher<[CartItemData], DomainError> {
    let requests = cart.products.map { item in
      Deferred {
        Future<CartItemData, DomainError> { [weak self] promise in
          self?.getProductUseCase.execute(id: item.productId) { result in
            switch result {
              case .success(let product):
                promise(.success(CartItemData(product: product, quantity: item.quantity)))
              case .failure(let error):
                promise(.failure(error))
            }
          }
        }
      }
      .eraseToAnyPublisher()
    }

    return Publishers.MergeMany(requests)
      .collect()
      .eraseToAnyPublisher()
  }

  func addProduct(_ item: CartItemData) {
    addProductHandler?(item.product)
  }

  func updateProduct(_ item: CartItemData, quantity: Int) {
    updateProductHandler?(item.product, quantity)
  }

  func removeProduct(_ item: CartItemData) {
    removeProductHandler?(item.product)
  }
}

