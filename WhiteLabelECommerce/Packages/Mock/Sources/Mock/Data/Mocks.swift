//
//  Mocks.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Backend
import Foundation

public struct Mocks {
  public static let product = Product(
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
  public static let products = [
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
      title: "Produc 2",
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
      id: 3,
      title: "Product 3",
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
      id: 4,
      title: "Product 4 ",
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
      id: 5,
      title: "Product 5",
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
      id: 6,
      title: "Product 6",
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
      id: 7,
      title: "Product 7",
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

  public static let productsData = """
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

  public static let cart = Cart(
    id: 1,
    userId: 1,
    date: Date(timeIntervalSince1970: 122_333),
    products: [cartItem]
  )

  public static let cartItem = CartItem(
    productId: 1,
    quantity: 1
  )

  public static let user = User(
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
