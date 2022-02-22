//
//  RemoteCreateCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

protocol CreateCartClient {
    func dispatch(createCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, HTTPError>)
}

class RemoteCreateCartUseCase: CreateCartUseCase {
    let client: CreateCartClient

    init(client: CreateCartClient) {
        self.client = client
    }

    func execute(cart: Cart, completion: @escaping CompletionHandler) {
        client.dispatch(createCart: cart) { result in
            switch result {
                case .success(let cart):
                    completion(.success(cart))

                case .failure(let error):
                    completion(.failure(.requestError(error: error)))
            }
        }
    }
}
