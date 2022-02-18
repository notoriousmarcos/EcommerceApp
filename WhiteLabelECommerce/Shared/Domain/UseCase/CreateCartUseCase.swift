//
//  CreateCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol CreateCartUseCase {
    typealias CompletionHandler = ResultCompletionHandler<Cart>
    func execute(
        createCartModel: CreateCartModel,
        completion: @escaping CompletionHandler
    )
}

struct CreateCartModel: Model {
    let userId: Int
    let date: Date
    let products: [Product]
}
