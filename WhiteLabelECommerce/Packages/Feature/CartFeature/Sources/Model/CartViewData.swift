//
//  CartViewData.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import ShopCore
import Foundation

class CartViewData: ObservableObject {
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

class CartItemData: ObservableObject {
  var product: Product
  var quantity: Int

  init(product: Product, quantity: Int) {
    self.product = product
    self.quantity = quantity
  }

  deinit { }
}
