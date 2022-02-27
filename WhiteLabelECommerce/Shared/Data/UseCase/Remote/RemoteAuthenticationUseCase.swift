//
//  RemoteAuthenticationUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/02/22.
//

import Foundation

protocol AuthenticationClient {
    func dispatch(
        authentication: AuthenticationModel,
        _ completion: @escaping ResultCompletionHandler<String, DomainError>
    )
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
            completion(result)
        }
    }
}
