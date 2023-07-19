//
//  GetAllProductsUseCase.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol GetAllProductsUseCase {
   typealias CompletionHandler = ResultCompletionHandler<[Product], DomainError>
   func execute(completion: @escaping CompletionHandler)
}
