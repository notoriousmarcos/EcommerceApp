//
//  UpdateCartRequest.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

struct UpdateCartRequest: Request {
    // MARK: - Typealias
    typealias ReturnType = Cart
    // MARK: - Properties
    let baseURL: String
    let method: HTTPMethod = .post
    let contentType: String = "application/json"
    let params: [String: Any]? = nil
    let body: [String: Any]?
    let headers: [String: String]? = nil

    init?(cart: Cart) {
        guard let cartId = cart.id else { return nil }
        baseURL = "https://fakestoreapi.com/carts/\(cartId)"
        self.body = cart.toJSON()
    }
}
