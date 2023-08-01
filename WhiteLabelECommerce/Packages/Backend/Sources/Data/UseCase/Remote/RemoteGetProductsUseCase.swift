//
//  RemoteGetAllProductsUseCase.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol GetProductsClient {
  func dispatch(offset: Int?, limit: Int?, _ completion: @escaping ResultCompletionHandler<[Product], DomainError>)
}

public class RemoteGetProductsUseCase: GetProductsUseCase {
  let client: GetProductsClient

  public init(client: GetProductsClient) {
    self.client = client
  }

  public func execute(offset: Int? = nil, limit: Int? = nil, completion: @escaping CompletionHandler) {
    client.dispatch(offset: offset, limit: limit) { (result: Result<[Product], DomainError>) in
      completion(result)
    }
  }

  deinit {
#if DEBUG
    // print("Deinit \(Self.self)")
#endif
  }
}
