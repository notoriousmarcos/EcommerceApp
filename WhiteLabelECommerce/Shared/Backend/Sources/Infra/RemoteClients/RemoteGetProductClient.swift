//
//  RemoteGetProductClient.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

import Foundation

public struct RemoteGetProductClient: GetProductClient {
  // MARK: - Properties
  private let client: HTTPClient

  // MARK: - init
  public init(client: HTTPClient) {
    self.client = client
  }

  // MARK: - Functions
  public func dispatch(productId id: Int, _ completion: @escaping ResultCompletionHandler<Product, DomainError>) {
    client.dispatch(request: GetProductRequest(id: id)) { result in
      completion(result)
    }
  }
}
