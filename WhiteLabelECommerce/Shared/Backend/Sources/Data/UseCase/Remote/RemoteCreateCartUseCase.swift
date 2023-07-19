//
//  RemoteCreateCartUseCase.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

public protocol CreateCartClient {
  func dispatch(createCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>)
}

public class RemoteCreateCartUseCase: CreateCartUseCase {
  let client: CreateCartClient
  
  public init(client: CreateCartClient) {
    self.client = client
  }
  
  public func execute(cart: Cart, completion: @escaping CompletionHandler) {
    client.dispatch(createCart: cart) { result in
      completion(result)
    }
  }
}
