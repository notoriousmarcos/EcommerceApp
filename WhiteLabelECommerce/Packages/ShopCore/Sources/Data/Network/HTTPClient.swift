//
//  HTTPClient.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public protocol HTTPClient {
    func dispatch<ReturnType: Codable>(
        request: Request,
        _ completion: @escaping ResultCompletionHandler<ReturnType, DomainError>
    )
}
