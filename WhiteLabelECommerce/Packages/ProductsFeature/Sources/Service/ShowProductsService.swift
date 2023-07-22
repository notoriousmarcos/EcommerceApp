//
//  ShowProductsService.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import Foundation
import Combine
import Backend

protocol ProductsService {
  func fetchProducts(for offset: Int?, and limit: Int?) -> AnyPublisher<[Product], ShowProductsServiceError>
}

class ShowProductsService: ProductsService {

  func fetchProducts(for offset: Int? = nil, and limit: Int? = nil) -> AnyPublisher<[Product], ShowProductsServiceError> {
    Just([
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
    ])
    .setFailureType(to: ShowProductsServiceError.self)
    .eraseToAnyPublisher()
  }
}
