//
//  CreateCartRequest.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

import Foundation

struct CreateCartRequest: Request {
    // MARK: - Typealias
    typealias ReturnType = Cart
    // MARK: - Properties
    let baseURL: String = "https://fakestoreapi.com/carts"
    let method: HTTPMethod = .post
    let contentType: String = "application/json"
    let params: [String: Any]? = nil
    let body: [String: Any]?
    let headers: [String: String]? = nil

    init(cart: Cart) {
        self.body = cart.toJSON()
    }
}
