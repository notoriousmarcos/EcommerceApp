//
//  AuthenticationRequest.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 25/02/22.
//

import Foundation

struct AuthenticationRequest: Request {
    // MARK: - Properties
    let path: String = "/auth/login"
    let method: HTTPMethod = .post
    let contentType: String = "application/json"
    let params: [String: String]? = nil
    let body: [String: Any]?
    let headers: [String: String]? = nil

    init(model: AuthenticationModel) {
        self.body = model.toJSON()
    }
}
