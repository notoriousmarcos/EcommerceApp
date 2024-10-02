//
//  InfraComposr.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import Foundation
import ShopCore

// MARK: - InfraComposr
extension AppView {
  var httpClient: HTTPClient {
    NativeHTTPClient()
  }
}
