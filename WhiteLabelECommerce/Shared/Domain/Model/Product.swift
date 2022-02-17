//
//  Product.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

struct Product: Model {

    // MARK: - Properties
    let id: Int
    let title: String
    let price: Double
    let category: String
    let description: String
    let imageURL: String
}
