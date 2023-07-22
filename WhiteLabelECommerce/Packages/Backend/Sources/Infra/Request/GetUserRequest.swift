//
//  GetUserRequest.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

struct GetUserRequest: Request {
    // MARK: - Properties
    let path: String
    let method: HTTPMethod = .get
    let contentType: String = "application/json"
    let params: [String: String]? = nil
    let body: [String: Any]? = nil
    let headers: [String: String]? = nil

    init(id: Int) {
        path = "/users/\(id)"
    }
}
