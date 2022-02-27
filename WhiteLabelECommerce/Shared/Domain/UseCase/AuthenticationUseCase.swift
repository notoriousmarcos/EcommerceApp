//
//  AuthenticationUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol AuthenticationUseCase {
    typealias CompletionHandler = ResultCompletionHandler<String, DomainError>
    func execute(
        authenticationModel: AuthenticationModel,
        completion: @escaping CompletionHandler
    )
}

struct AuthenticationModel: Model {
    var email: String
    var password: String
}
