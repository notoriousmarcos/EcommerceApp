//
//  RemoteGetProductUseCase.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol GetProductClient {
  func dispatch(productId id: Int, _ completion: @escaping ResultCompletionHandler<Product, DomainError>)
}

public class RemoteGetProductUseCase: GetProductUseCase {
  let client: GetProductClient

  public init(client: GetProductClient) {
    self.client = client
  }

  public func execute(id: Int, completion: @escaping CompletionHandler) {
    client.dispatch(productId: id) { result in
      completion(result)
    }
  }
}
