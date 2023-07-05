//
//  Collection.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

enum ProductSort {
  case ascending, descending, minPrice, maxPrice

  func title() -> String {
    switch self {
      case .ascending:
        return "by ascending relevance"
      case .descending:
        return "by descending relevance"
      case .minPrice:
        return "by min price"
      case .maxPrice:
        return "by max price"
    }
  }

  func sortByAPI() -> String {
    switch self {
      case .ascending:
        return "asc"
      case .descending:
        return "desc"
      default:
        return ""
    }
  }
}
