//
//  AddProductToCartUseCase.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol AddProductToCartUseCase {
   typealias CompletionHandler = ResultCompletionHandler<Cart, DomainError>
   func execute(
        _ product: Product,
        toCart cart: Cart,
        completion: @escaping CompletionHandler
    )
}
