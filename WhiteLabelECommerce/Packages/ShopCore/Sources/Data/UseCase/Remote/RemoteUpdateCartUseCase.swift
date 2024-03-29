//
//  RemoteUpdateCartUseCase.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

public protocol UpdateCartClient {
  func dispatch(updateCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>)
}

class RemoteUpdateCartUseCase: UpdateCartUseCase {
  let client: UpdateCartClient

  init(client: UpdateCartClient) {
    self.client = client
  }

  func execute(
    cart: Cart,
    completion: @escaping CompletionHandler
  ) {
    client.dispatch(updateCart: cart) { result in
      completion(result)
    }
  }

  deinit {
#if DEBUG
    // print("Deinit \(Self.self)")
#endif
  }
}
