//
//  GetUserUseCase.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol GetUserUseCase {
   typealias CompletionHandler = ResultCompletionHandler<User, DomainError>
   func execute(
        userId: Int,
        completion: @escaping CompletionHandler
    )
}
