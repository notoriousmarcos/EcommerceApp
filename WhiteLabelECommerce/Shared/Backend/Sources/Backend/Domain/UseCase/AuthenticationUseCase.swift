//
//  AuthenticationUseCase.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol AuthenticationUseCase {
   typealias CompletionHandler = ResultCompletionHandler<String, DomainError>
   func execute(
        authenticationModel: AuthenticationModel,
        completion: @escaping CompletionHandler
    )
}

public struct AuthenticationModel: Model {
    var email: String
    var password: String
}
