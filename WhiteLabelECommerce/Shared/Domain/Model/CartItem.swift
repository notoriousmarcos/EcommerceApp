//
//  CartItem.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

import Foundation

struct CartItem: Model {
    // MARK: - Properties
    let productId: Int
    private(set) var quantity: Int

    // MARK: - Functions
    mutating func setQuantity(_ quantity: Int) {
        self.quantity = quantity
    }
}
