//
//  HTTPError.swift
//  ShopCore
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public enum HTTPError: Int, Error {
  case urlError = -1002
  case badRequest = 400
  case unauthorized = 401
  case forbidden = 403
  case notFound = 404
  case timeOut = 408
  case serverError = 500
  case unknown = -1

  public init(rawValue: Int) {
    switch rawValue {
      case -1002:
        self = .urlError
      case 400:
        self = .badRequest
      case 401:
        self = .unauthorized
      case 403:
        self = .forbidden
      case 404:
        self = .notFound
      case 408:
        self = .timeOut
      case 500:
        self = .serverError
      default:
        self = .unknown
    }
  }
}
