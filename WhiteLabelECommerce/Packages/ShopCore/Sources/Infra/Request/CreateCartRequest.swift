//
//  CreateCartRequest.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

import Foundation

struct CreateCartRequest: Request {
  // MARK: - Properties
  let path: String = "/carts"
  let method: HTTPMethod = .post
  let contentType: String = "application/json"
  let params: [String: String]? = nil
  let body: [String: Any]?
  let headers: [String: String]? = nil

  init(cart: Cart) {
    self.body = cart.toJSON()
  }
}
