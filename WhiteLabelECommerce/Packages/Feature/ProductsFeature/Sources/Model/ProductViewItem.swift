//
//  ProductViewItem.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import Foundation

public struct ProductViewItem: Hashable, Equatable {
  // MARK: - Properties
  let id: Int
  let title: String
  let price: Double
  let category: CategoryItemView
  let description: String
  let imagesURL: [URL]

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
