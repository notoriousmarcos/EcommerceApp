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
    static let products = [
        Product(
            id: 1,
            title: "Product",
            price: 10.0,
            category: "men's clothing",
            description: "Product description",
            imageURL: "https://imageurl"
        ),
        Product(
            id: 2,
            title: "Product",
            price: 10.0,
            category: "Women's clothing",
            description: "Product description",
            imageURL: "https://imageurl"
        )
    ]
    static let productsData = """
        [
            {
                \"id\":1,
                \"title\":\"Product\",
                \"price\":10.0,
                \"category\":\"men's clothing\",
                \"description\":\"Product description\",
                \"imageURL\":\"https://imageurl\"
            },
            {
                \"id\":2,
                \"title\":\"Product\",
                \"price\":10.0,
                \"category\":\"Women's clothing\",
                \"description\":\"Product description\",
                \"imageURL\":\"https://imageurl\"
            }
        ]
    """.data(using: .utf8)
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
    static let user = User(
        id: 1,
        email: "a@a",
        username: "username",
        auth: Authentication(token: "token"),
        firstName: "firstname",
        lastName: "lastname",
        address: "address",
        phone: "1111111"
    )
}
