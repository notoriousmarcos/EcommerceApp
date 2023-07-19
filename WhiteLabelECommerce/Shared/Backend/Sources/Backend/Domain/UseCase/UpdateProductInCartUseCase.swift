//
//  UpdateProductInCartUseCase.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol UpdateProductInCartUseCase {
   typealias CompletionHandler = ResultCompletionHandler<Cart, DomainError>
   func execute(
        _ product: Product,
        withQuantity quantity: Int,
        inCart cart: Cart,
        completion: @escaping CompletionHandler
    )
}
