//
//  RemoteGetCurrentCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

class RemoteGetCurrentCartUseCase: GetCurrentCartUseCase {
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func execute(id: Int, completion: @escaping CompletionHandler) {
        guard let urlRequest = GetProductRequest(id: id).asURLRequest() else {
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
