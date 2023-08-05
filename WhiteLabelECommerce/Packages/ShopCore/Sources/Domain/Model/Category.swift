//
//  Category.swift
//  
//
//  Created by Marcos Vinicius Brito on 20/07/23.
//

import Foundation

public struct Category: Model {
  // MARK: - Properties
  public let id: Int
  public let name: String
  public let imageURL: String?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case imageURL = "image"
  }

  public init(id: Int, name: String, imageURL: String?) {
    self.id = id
    self.name = name
    self.imageURL = imageURL
  }
}
