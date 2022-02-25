//
//  DomainError.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 22/02/22.
//

import Foundation

enum DomainError: Error {
    case unknown(error: Error?)
    case requestError(error: HTTPError)
    case errorOnParsing(error: Error)
    case guardError(error: Error)
}
