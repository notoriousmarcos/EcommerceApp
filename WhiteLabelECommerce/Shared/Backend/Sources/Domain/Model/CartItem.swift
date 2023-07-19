//
//  CartItem.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

import Foundation

public struct CartItem: Model {
  // MARK: - Properties
  public let productId: Int
  public private(set) var quantity: Int

  // MARK: - Functions
  mutating func setQuantity(_ quantity: Int) {
    self.quantity = quantity
  }

  public init(productId: Int, quantity: Int) {
    self.productId = productId
    self.quantity = quantity
  }
}
