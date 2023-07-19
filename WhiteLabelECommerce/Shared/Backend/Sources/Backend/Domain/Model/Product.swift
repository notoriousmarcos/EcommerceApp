//
//  Product.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

public struct Product: Model {
  // MARK: - Properties
  public let id: Int
  public let title: String
  public let price: Double
  public let category: String
  public let description: String
  public let imageURL: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case price
    case category
    case description
    case imageURL = "image"
  }

  public init(id: Int, title: String, price: Double, category: String, description: String, imageURL: String?) {
    self.id = id
    self.title = title
    self.price = price
    self.category = category
    self.description = description
    self.imageURL = imageURL
  }
}
