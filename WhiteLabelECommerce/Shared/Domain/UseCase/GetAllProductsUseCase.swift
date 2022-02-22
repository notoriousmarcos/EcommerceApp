//
//  GetAllProductsUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol GetAllProductsUseCase {
    typealias CompletionHandler = ResultCompletionHandler<[Product], DomainError>
    func execute(completion: @escaping CompletionHandler)
}
