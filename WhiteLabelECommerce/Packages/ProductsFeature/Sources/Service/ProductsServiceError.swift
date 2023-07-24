//
//  ServiceError.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import Foundation

enum ProductsServiceError: String, Error, Equatable {
  case decoding
  case requestFail
  case guardError
  case unknown
}
