//
//  RemoteGetCurrentCartUseCase.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol GetCurrentCartClient {
  func dispatch(userId id: Int, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>)
}

class RemoteGetCurrentCartUseCase: GetCurrentCartUseCase {
  let client: GetCurrentCartClient

  init(client: GetCurrentCartClient) {
    self.client = client
  }

  func execute(userId: Int, completion: @escaping CompletionHandler) {
    client.dispatch(userId: userId) { result in
      completion(result)
    }
  }

  deinit {
#if DEBUG
    // print("Deinit \(Self.self)")
#endif
  }
}
