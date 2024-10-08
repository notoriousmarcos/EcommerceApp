//
//  CartViewData.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import Foundation
import ShopCore

class CartViewData {
  var id: Int?
  var userId: Int
  var date: Date
  var products: [CartItemData]

  init(id: Int? = nil, userId: Int, date: Date, products: [CartItemData]) {
    self.id = id
    self.userId = userId
    self.date = date
    self.products = products
  }

  deinit { }
}

public class CartItemData: Identifiable {
  public var id: Int {
    product.id
  }
  var product: Product
  var quantity: Int

  init(product: Product, quantity: Int) {
    self.product = product
    self.quantity = quantity
  }

  deinit { }
}
