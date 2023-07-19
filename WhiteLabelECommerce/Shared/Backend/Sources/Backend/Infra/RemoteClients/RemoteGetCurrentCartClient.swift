//
//  RemoteGetCurrentCartClient.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

import Foundation

public struct RemoteGetCurrentCartClient: GetCurrentCartClient {
  // MARK: - Properties
  private let client: HTTPClient
  
  // MARK: - init
  public init(client: HTTPClient) {
    self.client = client
  }
  
  // MARK: - Functions
  public func dispatch(userId id: Int, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>) {
    client.dispatch(request: GetCurrentCartRequest(userId: id)) { result in
      completion(result)
    }
  }
}
