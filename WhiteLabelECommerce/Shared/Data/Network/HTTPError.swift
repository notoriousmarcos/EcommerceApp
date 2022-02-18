//
//  HTTPError.swift
//  WhiteLabelECommerce
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

enum HTTPError: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case timeOut = 408
    case serverError = 500
    case unknown = -1

    init(rawValue: Int) {
        switch rawValue {
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
