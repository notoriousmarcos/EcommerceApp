//
//  RemoteGetUserUseCase.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 23/02/22.
//

import Foundation

public protocol GetUserClient {
  func dispatch(
    userId: Int,
    _ completion: @escaping ResultCompletionHandler<User, DomainError>
  )
}

class RemoteGetUserUseCase: GetUserUseCase {
  let client: GetUserClient

  init(client: GetUserClient) {
    self.client = client
  }

  func execute(
    userId: Int,
    completion: @escaping CompletionHandler
  ) {
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
