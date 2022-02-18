//
//  UpdateProductInCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol UpdateProductInCartUseCase {
    typealias CompletionHandler = ResultCompletionHandler<Cart, Error>
    func execute(
        _ product: Product,
        inCart cart: Cart,
        completion: @escaping CompletionHandler
    )
}
