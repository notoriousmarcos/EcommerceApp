//
//  RemoteGetCurrentCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol GetCurrentCartClient {
    func dispatch(userId id: Int, _ completion: @escaping ResultCompletionHandler<Cart, HTTPError>)
}

class RemoteGetCurrentCartUseCase: GetCurrentCartUseCase {
    let client: GetCurrentCartClient

    init(client: GetCurrentCartClient) {
        self.client = client
    }

    func execute(userId: Int, completion: @escaping CompletionHandler) {
        client.dispatch(userId: userId) { result in
            switch result {
                case .success(let cart):
                    completion(.success(cart))

                case .failure(let error):
                    completion(.failure(error))
            }
        }

    }
}
