//
//  Cart.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

struct Cart: Model {
    // MARK: - Properties
    let id: Int
    let userId: Int
    let date: Date
    let products: [Product]
}
