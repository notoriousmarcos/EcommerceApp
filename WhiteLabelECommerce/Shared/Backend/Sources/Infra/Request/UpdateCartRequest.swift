//
//  UpdateCartRequest.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

struct UpdateCartRequest: Request {
    // MARK: - Properties
    let path: String
    let method: HTTPMethod = .put
    let contentType: String = "application/json"
    let params: [String: String]? = nil
    let body: [String: Any]?
    let headers: [String: String]? = nil

    init?(cart: Cart) {
        guard let cartId = cart.id else { return nil }
        path = "/carts/\(cartId)"
        self.body = cart.toJSON()
    }
}
