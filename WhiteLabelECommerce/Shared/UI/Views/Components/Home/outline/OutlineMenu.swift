//
//  OutlineMenu.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation
import SwiftUI

enum OutlineMenu: Int, CaseIterable, Identifiable {
  var id: Int {
    return self.rawValue
  }

  case products

  var title: String {
    switch self {
      case .products: return "Products"
    }
  }

  var image: String {
    switch self {
      case .products: return "film.fill"
    }
  }
}
