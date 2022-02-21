//
//  Cart.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

struct Cart: Model {
    // MARK: - Properties
    private(set) var id: Int?
    private(set) var userId: Int
    private(set) var date: Date
    private(set) var products: [CartItem]
}
