//
//  RemoteCreateCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

protocol CreateCartClient {
    func dispatch(createCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>)
}

class RemoteCreateCartUseCase: CreateCartUseCase {
    let client: CreateCartClient

    init(client: CreateCartClient) {
        self.client = client
    }

    func execute(cart: Cart, completion: @escaping CompletionHandler) {
        client.dispatch(createCart: cart) { result in
            completion(result)
        }
    }
}
