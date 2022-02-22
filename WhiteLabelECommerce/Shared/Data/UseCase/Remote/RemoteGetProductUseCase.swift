//
//  RemoteGetProductUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol GetProductClient {
    func dispatch(productId id: Int, _ completion: @escaping ResultCompletionHandler<Product, HTTPError>)
}

class RemoteGetProductUseCase: GetProductUseCase {
    let client: GetProductClient

    init(client: GetProductClient) {
        self.client = client
    }

    func execute(id: Int, completion: @escaping CompletionHandler) {
        client.dispatch(productId: id) { (result: Result<Product, HTTPError>) in
            switch result {
                case .success(let product):
                    completion(.success(product))

                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
