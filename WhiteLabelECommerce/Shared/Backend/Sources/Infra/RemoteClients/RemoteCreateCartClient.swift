//
//  RemoteCreateCartClient.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

import Foundation

public struct RemoteCreateCartClient: CreateCartClient {
  // MARK: - Properties
  private let client: HTTPClient

  // MARK: - init
  public init(client: HTTPClient) {
    self.client = client
  }

  // MARK: - Functions
  public func dispatch(createCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>) {
    client.dispatch(request: CreateCartRequest(cart: cart)) { result in
      completion(result)
    }
  }
}
