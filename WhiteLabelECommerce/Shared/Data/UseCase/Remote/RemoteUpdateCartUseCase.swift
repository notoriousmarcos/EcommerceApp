//
//  RemoteUpdateCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

protocol UpdateCartClient {
    func dispatch(updateCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, HTTPError>)
}

class RemoteUpdateCartUseCase: UpdateCartUseCase {
    let client: UpdateCartClient

    init(client: UpdateCartClient) {
        self.client = client
    }

    func execute(
        cart: Cart,
        completion: @escaping CompletionHandler
    ) {
        client.dispatch(updateCart: cart) { result in
            switch result {
                case .success(let cart):
                    completion(.success(cart))

                case .failure(let error):
                    completion(.failure(.requestError(error: error)))
            }
        }
    }
}
