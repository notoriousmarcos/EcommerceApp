//
//  Authentication.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public struct Authentication: Model {
  // MARK: - Properties
  public let token: String

  public init(token: String) {
    self.token = token
  }
}
