//
//  RemoteGetAllProductsClient.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

import Foundation

struct RemoteGetAllProductsClient: GetAllProductsClient {
    // MARK: - Properties
    private let client: HTTPClient

    // MARK: - init
    init(client: HTTPClient) {
        self.client = client
    }

    // MARK: - Functions
    func dispatch(_ completion: @escaping ResultCompletionHandler<[Product], DomainError>) {
        client.dispatch(request: GetAllProductsRequest()) { result in
            completion(result)
        }
    }
}
