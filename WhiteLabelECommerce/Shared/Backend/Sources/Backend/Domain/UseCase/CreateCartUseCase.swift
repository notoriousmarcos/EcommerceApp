//
//  CreateCartUseCase.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol CreateCartUseCase {
   typealias CompletionHandler = ResultCompletionHandler<Cart, DomainError>
   func execute(
        cart: Cart,
        completion: @escaping CompletionHandler
    )
}
