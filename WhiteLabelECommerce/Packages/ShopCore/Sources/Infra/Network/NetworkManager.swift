//
//  NetworkManager.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

import Foundation

protocol NetworkManager {
    func dispatch<T: Codable>(request: Request, _ completion: @escaping ResultCompletionHandler<T, DomainError>)
}
