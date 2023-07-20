//
//  RemoteGetAllProductsClient.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

import Foundation

public struct RemoteGetProductsClient: GetProductsClient {
  // MARK: - Properties
  private let client: HTTPClient

  // MARK: - init
  public init(client: HTTPClient) {
    self.client = client
  }

  // MARK: - Functions
  public func dispatch(
    offset: Int?,
    limit: Int?,
    _ completion: @escaping ResultCompletionHandler<[Product], DomainError>
  ) {
    client.dispatch(request: GetProductsRequest(offset: offset, limit: limit)) { result in
      completion(result)
    }
  }
}
