//
//  RemoteGetAllProductsUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

class RemoteGetAllProductsUseCase: GetAllProductsUseCase {
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func execute(completion: @escaping CompletionHandler) {
        guard let urlRequest = GetAllProductsRequest().asURLRequest() else {
            return
        }

        client.dispatch(
            request: urlRequest,
            completion: { (result: Result<[Product], HTTPError>) in
                switch result {
                    case .success(let products):
                        completion(.success(products))

                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        )
    }
}
