//
//  InfraComposr.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import Backend
import Foundation

// MARK: - InfraComposr
extension CompositionRoot {
  static var httpClient: HTTPClient {
    NativeHTTPClient()
  }
}
