//
//  RemoteGetAllProductsUseCase.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol GetAllProductsClient {
  func dispatch(_ completion: @escaping ResultCompletionHandler<[Product], DomainError>)
}

public class RemoteGetAllProductsUseCase: GetAllProductsUseCase {
  let client: GetAllProductsClient

  public init(client: GetAllProductsClient) {
    self.client = client
  }
  
  public func execute(completion: @escaping CompletionHandler) {
    client.dispatch { (result: Result<[Product], DomainError>) in
      completion(result)
    }
  }
}
