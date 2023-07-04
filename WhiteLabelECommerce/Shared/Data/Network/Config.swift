//
//  Config.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 04/07/23.
//

import Foundation

public enum Config {
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist not found")
    }
    return dict
  }()

  static let baseURL: URL = {
    guard let baseURL = Self.infoDictionary[Keys.baseURL.rawValue] as? String else {
      fatalError("Base URL not set in plist")
    }
    var components = URLComponents()
    components.scheme = "https"
    components.host = baseURL
    guard let url = components.url else {
      fatalError("Base URL is invalid")
    }
    return url
  }()

  private enum Keys: String {
    case baseURL
  }
}
