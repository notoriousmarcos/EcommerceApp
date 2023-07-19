//
//  UpdateCartUseCase.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

public protocol UpdateCartUseCase {
   typealias CompletionHandler = ResultCompletionHandler<Cart, DomainError>
   func execute(
        cart: Cart,
        completion: @escaping CompletionHandler
    )
}
