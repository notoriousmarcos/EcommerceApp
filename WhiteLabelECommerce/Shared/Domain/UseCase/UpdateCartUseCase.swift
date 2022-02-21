//
//  UpdateCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

protocol UpdateCartUseCase {
    typealias CompletionHandler = ResultCompletionHandler<Cart, Error>
    func execute(
        cart: Cart,
        completion: @escaping CompletionHandler
    )
}
