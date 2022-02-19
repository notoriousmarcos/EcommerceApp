//
//  GetCurrentCartRequest.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

struct GetCurrentCartRequest: Request {
    // MARK: - Typealias
    typealias ReturnType = Cart
    // MARK: - Properties
    let baseURL: String
    let method: HTTPMethod = .get
    let contentType: String = "application/json"
    let params: [String: Any]? = nil
    let body: [String: Any]? = nil
    let headers: [String: String]? = nil

    init(id: Int) {
        baseURL = "https://fakestoreapi.com/carts/user/\(id)"
    }
}
