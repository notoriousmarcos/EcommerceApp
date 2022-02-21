//
//  RemoteUpdateCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

class RemoteUpdateCartUseCase: UpdateCartUseCase {
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func execute(
        cart: Cart,
        completion: @escaping CompletionHandler
    ) {
        guard let urlRequest = UpdateCartRequest(cart: cart)?.asURLRequest() else {
            return
        }

        client.dispatch(
            request: urlRequest,
            completion: { (result: Result<Cart, HTTPError>) in
                switch result {
                    case .success(let cart):
                        completion(.success(cart))

                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        )
    }
}
