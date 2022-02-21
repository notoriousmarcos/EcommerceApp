//
//  Mocks.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation
@testable import WhiteLabelECommerce

struct Mocks {
    static let product = Product(
        id: 1,
        title: "Product",
        price: 10.0,
        category: "men's clothing",
        description: "Product description",
        imageURL: "https:imageurl"
    )
    static let cart = Cart(
        id: 1,
        userId: 1,
        date: Date(timeIntervalSince1970: 122_333),
        products: [cartItem]
    )
    static let cartItem = CartItem(
        productId: 1,
        quantity: 1
    )
}
