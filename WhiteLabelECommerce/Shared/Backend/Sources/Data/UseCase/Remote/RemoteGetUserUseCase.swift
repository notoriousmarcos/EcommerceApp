//
//  RemoteGetUserUseCase.swift
//  Backend
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

public class RemoteGetUserUseCase: GetUserUseCase {
  let client: GetUserClient

  public init(client: GetUserClient) {
    self.client = client
  }

  public func execute(
    userId: Int,
    completion: @escaping CompletionHandler
  ) {
    client.dispatch(userId: userId) { result in
      completion(result)
    }
  }
}
