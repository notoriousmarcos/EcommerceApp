//
//  GetProductUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol GetProductUseCase {
    typealias CompletionHandler = ResultCompletionHandler<Product, Error>
    func execute(id: Int, completion: @escaping CompletionHandler)
}
