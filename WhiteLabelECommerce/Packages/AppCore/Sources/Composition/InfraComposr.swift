//
//  InfraComposr.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import Foundation
import Backend

// MARK: - InfraComposr
extension CompositionRoot {
  static var httpClient: HTTPClient {
    NativeHTTPClient()
  }
}
