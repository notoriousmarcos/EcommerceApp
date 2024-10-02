//
//  Mocks.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation
import ShopCore

struct Mocks {
    static let product = Product(
        id: 1,
        title: "Product",
        price: 10.0,
        category: Category(
          id: 5,
          name: "Others",
          imageURL: "https://placeimg.com/640/480/any?r=0.591926261873231"
        ),
        description: "Product description",
        imagesURL: ["https://imageurl"]
    )
    static let products = [
        Product(
            id: 1,
            title: "Product",
            price: 10.0,
            category: Category(
              id: 5,
              name: "Others",
              imageURL: "https://placeimg.com/640/480/any?r=0.591926261873231"
            ),
            description: "Product description",
            imagesURL: ["https://imageurl"]
        ),
        Product(
            id: 2,
            title: "Product",
            price: 10.0,
            category: Category(
              id: 5,
              name: "Others",
              imageURL: "https://placeimg.com/640/480/any?r=0.591926261873231"
            ),
            description: "Product description",
            imagesURL: ["https://imageurl"]
        )
    ]
    static let productsData = """
        [
            {
                \"id\":1,
                \"title\":\"Product\",
                \"price\":10.0,
                \"category\": {
                  \"id\": 5,
                  \"name\": \"Others\",
                  \"image\": \"https://placeimg.com/640/480/any?r=0.591926261873231\"
                },
                \"description\":\"Product description\",
                \"images\": [\"https://imageurl\"]
            },
            {
                \"id\":2,
                \"title\":\"Product\",
                \"price\":10.0,
                \"category\": {
                  \"id\": 5,
                  \"name\": \"Others\",
                  \"image\": \"https://placeimg.com/640/480/any?r=0.591926261873231\"
                },
                \"description\":\"Product description\",
                \"images\": [\"https://imageurl\"]
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
