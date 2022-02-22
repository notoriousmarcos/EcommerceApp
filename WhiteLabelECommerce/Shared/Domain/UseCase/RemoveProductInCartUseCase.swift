//
//  RemoveProductInCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol RemoveProductInCartUseCase {
    typealias CompletionHandler = ResultCompletionHandler<Cart, DomainError>
    func execute(
        _ product: Product,
        inCart cart: Cart,
        completion: @escaping CompletionHandler
    )
}
