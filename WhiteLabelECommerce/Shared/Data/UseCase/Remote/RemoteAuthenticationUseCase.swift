//
//  RemoteAuthenticationUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/02/22.
//

import Foundation

protocol AuthenticationClient {
    func dispatch(authentication: AuthenticationModel, _ completion: @escaping ResultCompletionHandler<User, HTTPError>)
}

class RemoteAuthenticationUseCase: AuthenticationUseCase {
    let client: AuthenticationClient

    init(client: AuthenticationClient) {
        self.client = client
    }

    func execute(
        authenticationModel: AuthenticationModel,
        completion: @escaping CompletionHandler
    ) {
        client.dispatch(authentication: authenticationModel) { result in
            switch result {
                case .success(let cart):
                    completion(.success(cart))

                case .failure(let error):
                    completion(.failure(.requestError(error: error)))
            }
        }
    }
}
