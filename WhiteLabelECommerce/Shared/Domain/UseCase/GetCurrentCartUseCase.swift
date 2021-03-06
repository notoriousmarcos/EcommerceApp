//
//  GetCurrentCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol GetCurrentCartUseCase {
    typealias CompletionHandler = ResultCompletionHandler<Cart, DomainError>
    func execute(userId: Int, completion: @escaping CompletionHandler)
}
