//
//  ColorScheme.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation
import SwiftUI

public extension Color {
  static var primaryColor: Color {
    Color("primary", bundle: .module)
  }

  static var secondaryColor: Color {
    Color("secondary", bundle: .module)
  }

  static var backgroundColor: Color {
    Color("background", bundle: .module)
  }
}
