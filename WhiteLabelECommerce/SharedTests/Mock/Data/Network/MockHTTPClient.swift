//
//  MockHTTPClient.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation
@testable import WhiteLabelECommerce
import XCTest

class MockHTTPClient: HTTPClient {
    let url = URL(string: "https://google.com")!
    var result: Any?
    var error: HTTPError?

    func dispatch<ReturnType: Codable>(
        request: URLRequest,
        completion: @escaping ResultCompletionHandler<ReturnType, HTTPError>
    ) {
        if let result = result as? ReturnType {
            completion(.success(result))
        } else {
            completion(.failure(error ?? .unknown))
        }
    }
}

extension MockHTTPClient: GetAllProductsClient {
    func dispatch(_ completion: @escaping ResultCompletionHandler<[Product], HTTPError>) {
        dispatch(
            request: URLRequest(url: url),
            completion: { (result: Result<[Product], HTTPError>) in
                switch result {
                    case .success(let products):
                        completion(.success(products))

                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        )
    }
}

extension MockHTTPClient: GetProductClient {
    func dispatch(productId id: Int, _ completion: @escaping ResultCompletionHandler<Product, HTTPError>) {
        dispatch(
            request: URLRequest(url: url),
            completion: { (result: Result<Product, HTTPError>) in
                switch result {
                    case .success(let product):
                        completion(.success(product))

                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        )
    }
}

extension MockHTTPClient: GetCurrentCartClient {
    func dispatch(userId id: Int, _ completion: @escaping ResultCompletionHandler<Cart, HTTPError>) {
        dispatch(
            request: URLRequest(url: url),
            completion: { (result: Result<Cart, HTTPError>) in
                switch result {
                    case .success(let cart):
                        completion(.success(cart))

                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        )
    }
}

extension MockHTTPClient: CreateCartClient {
    func dispatch(createCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, HTTPError>) {
        dispatch(
            request: URLRequest(url: url),
            completion: { (result: Result<Cart, HTTPError>) in
                switch result {
                    case .success(let cart):
                        completion(.success(cart))

                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        )
    }
}

extension MockHTTPClient: UpdateCartClient {
    func dispatch(updateCart cart: Cart, _ completion: @escaping ResultCompletionHandler<Cart, HTTPError>) {
        dispatch(
            request: URLRequest(url: url),
            completion: { (result: Result<Cart, HTTPError>) in
                switch result {
                    case .success(let cart):
                        completion(.success(cart))

                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        )
    }
}

extension MockHTTPClient: AuthenticationClient {
    func dispatch(
        authentication: AuthenticationModel,
        _ completion: @escaping ResultCompletionHandler<User, HTTPError>
    ) {
        dispatch(
            request: URLRequest(url: url),
            completion: { (result: Result<User, HTTPError>) in
                switch result {
                    case .success(let user):
                        completion(.success(user))

                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        )
    }
}
