//
//  RemoteGetAllProductsClient.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

import Foundation

struct RemoteGetAllProductsClient: GetAllProductsClient {
    // MARK: - Properties
    let client: HTTPClient

    // MARK: - init
    init(httpClient: HTTPClient) {
        client = httpClient
    }

    // MARK: - Functions
    func dispatch(_ completion: @escaping ResultCompletionHandler<[Product], DomainError>) {
        guard let request = GetAllProductsRequest().asURLRequest() else {
            completion(.failure(.requestError(error: .badRequest)))
            return
        }

        client.dispatch(request: request) { result in
            switch result {
                case .success(let data):
                    do {
                        let products = try JSONDecoder().decode([Product].self, from: data)
                        completion(
                            .success(products)
                        )
                    } catch {
                        completion(.failure(.errorOnParsing(error: error)))
                    }
                case .failure(let error):
                    completion(.failure(.requestError(error: error)))
            }
        }
    }
}
