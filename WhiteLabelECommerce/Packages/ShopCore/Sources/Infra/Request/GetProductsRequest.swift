//
//  GetAllProductsRequest.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

struct GetProductsRequest: Request {
  // MARK: - Properties
  let path: String = "/products"
  let method: HTTPMethod = .get
  let contentType: String = "application/json"
  var params: [String: String]?
  let body: [String: Any]? = nil
  let headers: [String: String]? = nil

  init(
    offset: Int? = nil,
    limit: Int? = nil
  ) {
    if let offset = offset, let limit = limit {
      params = [
        "offset": String(offset),
        "limit": String(limit)
      ]
    }
  }
}
