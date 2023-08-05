//
//  GetProductsUseCase.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol GetProductsUseCase {
  typealias CompletionHandler = ResultCompletionHandler<[Product], DomainError>
  func execute(offset: Int?, limit: Int?, completion: @escaping CompletionHandler)
}
