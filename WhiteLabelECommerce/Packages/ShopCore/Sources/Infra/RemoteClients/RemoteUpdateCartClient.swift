//
//  RemoteUpdateCartClient.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

import Foundation

public struct RemoteUpdateCartClient: UpdateCartClient {
  // MARK: - Properties
  private let client: HTTPClient

  // MARK: - init
  public init(client: HTTPClient) {
    self.client = client
  }

  // MARK: - Functions
  public func dispatch(updateCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>) {
    guard let request = UpdateCartRequest(cart: cart) else {
      completion(.failure(.requestError(error: .badRequest)))
      return
    }
    client.dispatch(request: request) { result in
      completion(result)
    }
  }
}
