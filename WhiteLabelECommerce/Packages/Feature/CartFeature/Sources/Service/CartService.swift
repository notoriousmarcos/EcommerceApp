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
  let removeProductHandler: ((Product) -> Void)?

  public init(
    addProductHandler: ((Product) -> Void)?,
    removeProductHandler: ((Product) -> Void)?,
    getProductUseCase: GetProductUseCase
  ) {
    self.addProductHandler = addProductHandler
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

  public func addProduct(_ product: Product) {
    addProductHandler?(product)
  }

  public func removeProduct(_ product: Product) {
    removeProductHandler?(product)
  }
}

