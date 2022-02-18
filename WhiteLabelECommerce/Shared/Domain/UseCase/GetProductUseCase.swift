//
//  GetProductUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol GetProductUseCase {
    typealias CompletionHandler = ResultCompletionHandler<Product>
    func execute(completion: @escaping CompletionHandler)
}
