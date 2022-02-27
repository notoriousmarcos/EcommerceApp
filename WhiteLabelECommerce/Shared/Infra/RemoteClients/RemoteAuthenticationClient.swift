//
//  RemoteAuthenticationClient.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 27/02/22.
//

import Foundation

struct RemoteAuthenticationClient: AuthenticationClient {
    // MARK: - Properties
    private let client: HTTPClient

    // MARK: - init
    init(client: HTTPClient) {
        self.client = client
    }

    func dispatch(
        authentication: AuthenticationModel,
        _ completion: @escaping ResultCompletionHandler<String, DomainError>
    ) {
        client.dispatch(
            request: AuthenticationRequest(model: authentication)
        ) { result in
            completion(result)
        }
    }
}
