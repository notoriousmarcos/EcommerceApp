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
        client.dispatch(request: CreateCartRequest(cart: cart)) { result in
            completion(result)
        }
    }
}
