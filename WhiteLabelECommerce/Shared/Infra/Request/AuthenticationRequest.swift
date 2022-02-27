//
//  AuthenticationRequest.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

import Foundation

struct AuthenticationRequest: Request {
    // MARK: - Properties
    let baseURL: String = "https://fakestoreapi.com/auth/login"
    let method: HTTPMethod = .post
    let contentType: String = "application/json"
    let params: [String: Any]? = nil
    let body: [String: Any]?
    let headers: [String: String]? = nil

    init(model: AuthenticationModel) {
        self.body = model.toJSON()
    }
}
