//
//  Config.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 04/07/23.
//

import Foundation

enum Config {
  static let baseURL: URL = {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.escuelajs.co"
    components.path = "/api/v1"
    guard let url = components.url else {
      fatalError("Base URL is invalid")
    }
    return url
  }()
}
