//
//  Cart.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

public struct Cart: Model {
  // MARK: - Properties
  public private(set) var id: Int?
  public private(set) var userId: Int
  public private(set) var date: Date
  public private(set) var products: [CartItem]

  public init(id: Int? = nil, userId: Int, date: Date, products: [CartItem]) {
    self.id = id
    self.userId = userId
    self.date = date
    self.products = products
  }

  // MARK: - Codable
  enum CodingKeys: CodingKey {
    case id, userId, date, products
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(userId, forKey: .userId)
    try container.encode(date.toString(), forKey: .date)
    try container.encode(products, forKey: .products)
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let id = try values.decode(Int.self, forKey: .id)
    let userId = try values.decode(Int.self, forKey: .userId)
    let dateString = try values.decode(String.self, forKey: .date)
    let products = try values.decode([CartItem].self, forKey: .products)
    guard let date = dateString.toDate() else {
      throw DecodingError.typeMismatch(
        Date.self,
        .init(
          codingPath: [CodingKeys.date],
          debugDescription: "Date is nil",
          underlyingError: nil
        )
      )
    }

    self = Cart(
      id: id,
      userId: userId,
      date: date,
      products: products
    )
  }
}
