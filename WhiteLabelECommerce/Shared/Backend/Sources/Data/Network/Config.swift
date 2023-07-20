//
//  Config.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 04/07/23.
//

import Foundation

enum Config {
  static let baseURL: URL = {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "fakestoreapi.com"
    guard let url = components.url else {
      fatalError("Base URL is invalid")
    }
    return url
  }()
}
