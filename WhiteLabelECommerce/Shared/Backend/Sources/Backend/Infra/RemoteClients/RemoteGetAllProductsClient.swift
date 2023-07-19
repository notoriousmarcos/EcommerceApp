//
//  RemoteGetAllProductsClient.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

import Foundation

public struct RemoteGetAllProductsClient: GetAllProductsClient {
  // MARK: - Properties
  private let client: HTTPClient

  // MARK: - init
  public init(client: HTTPClient) {
    self.client = client
  }

  // MARK: - Functions
  public func dispatch(_ completion: @escaping ResultCompletionHandler<[Product], DomainError>) {
    client.dispatch(request: GetAllProductsRequest()) { result in
      completion(result)
    }
  }
}
