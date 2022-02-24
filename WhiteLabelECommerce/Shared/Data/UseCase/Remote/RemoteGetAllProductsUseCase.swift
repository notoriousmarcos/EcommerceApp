//
//  RemoteGetAllProductsUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol GetAllProductsClient {
    func dispatch(_ completion: @escaping ResultCompletionHandler<[Product], DomainError>)
}

class RemoteGetAllProductsUseCase: GetAllProductsUseCase {
    let client: GetAllProductsClient

    init(client: GetAllProductsClient) {
        self.client = client
    }

    func execute(completion: @escaping CompletionHandler) {
        client.dispatch { (result: Result<[Product], DomainError>) in
            completion(result)
        }
    }
}
