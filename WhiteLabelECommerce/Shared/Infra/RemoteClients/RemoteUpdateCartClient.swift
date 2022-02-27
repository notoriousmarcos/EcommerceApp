//
//  RemoteUpdateCartClient.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

import Foundation

struct RemoteUpdateCartClient: UpdateCartClient {
    // MARK: - Properties
    private let client: HTTPClient

    // MARK: - init
    init(client: HTTPClient) {
        self.client = client
    }

    // MARK: - Functions
    func dispatch(updateCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>) {
        guard let request = UpdateCartRequest(cart: cart) else {
            completion(.failure(.requestError(error: .badRequest)))
            return
        }
        client.dispatch(request: request) { result in
            completion(result)
        }
    }
}
