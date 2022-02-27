//
//  MockClients.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

import Foundation
@testable import WhiteLabelECommerce
import XCTest

class MockClients {
    let url = URL(string: "https://google.com")!
    var result: Result<Codable, DomainError>?

    private func handleResult<T: Codable>(_ completion: ResultCompletionHandler<T, DomainError>) {
        if case let .success(value) = result,
           let value = value as? T {
            completion(.success(value))
        } else if case let .failure(error) = result {
            completion(.failure(error))
        } else {
            XCTFail("Result is nil or have an incorrect type.")
        }
    }
}

extension MockClients: GetAllProductsClient {
    func dispatch(_ completion: @escaping ResultCompletionHandler<[Product], DomainError>) {
        handleResult(completion)
    }
}

extension MockClients: GetProductClient {
    func dispatch(productId id: Int, _ completion: @escaping ResultCompletionHandler<Product, DomainError>) {
        handleResult(completion)
    }
}

extension MockClients: GetCurrentCartClient {
    func dispatch(userId id: Int, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>) {
        handleResult(completion)
    }
}

extension MockClients: CreateCartClient {
    func dispatch(createCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>) {
        handleResult(completion)
    }
}

extension MockClients: UpdateCartClient {
    func dispatch(updateCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, DomainError>) {
        handleResult(completion)
    }
}

extension MockClients: AuthenticationClient {
    func dispatch(
        authentication: AuthenticationModel,
        _ completion: @escaping ResultCompletionHandler<String, DomainError>
    ) {
        handleResult(completion)
    }
}

extension MockClients: GetUserClient {
    func dispatch(
        userId: Int,
        _ completion: @escaping ResultCompletionHandler<User, DomainError>
    ) {
        handleResult(completion)
    }
}
