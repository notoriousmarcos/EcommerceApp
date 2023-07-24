//
//  Font.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation
import SwiftUI

public extension Font {
  static func fHACondFrenchNC(size: CGFloat) -> Font {
    return Font.custom("FHA Condensed French NC", size: size)
  }

  static func americanCaptain(size: CGFloat) -> Font {
    return Font.custom("American Captain", size: size)
  }

  static func fjallaOne(size: CGFloat) -> Font {
    return Font.custom("FjallaOne-Regular", size: size)
  }
}

public struct TextFont: ViewModifier {
  let size: CGFloat

  public func body(content: Content) -> some View {
    return content.font(.fHACondFrenchNC(size: size))
  }
}

public extension View {
  func textFont(size: CGFloat) -> some View {
    return ModifiedContent(content: self, modifier: TextFont(size: size))
  }

  func titleStyle() -> some View {
    return ModifiedContent(content: self, modifier: TextFont(size: 16))
  }
}
