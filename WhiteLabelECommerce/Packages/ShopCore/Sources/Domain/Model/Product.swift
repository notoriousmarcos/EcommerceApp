//
//  Product.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

public struct Product: Model {
  // MARK: - Properties
  public let id: Int
  public let title: String
  public let price: Double
  public let category: Category
  public let description: String
  public let imagesURL: [String]

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case price
    case category
    case description
    case imagesURL = "images"
  }

  public init(id: Int, title: String, price: Double, category: Category, description: String, imagesURL: [String]) {
    self.id = id
    self.title = title
    self.price = price
    self.category = category
    self.description = description
    self.imagesURL = imagesURL
  }
}
