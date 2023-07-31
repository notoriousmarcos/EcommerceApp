//
//  ImageStyle.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

public struct ImageStyle: ViewModifier {
  let loaded: Bool

  public func body(content: Content) -> some View {
    return content
      .cornerRadius(5)
      .opacity(loaded ? 1 : 0.1)
      .shadow(radius: 8)
  }
}

public extension View {
  func imageStyle(loaded: Bool) -> some View {
    return ModifiedContent(content: self, modifier: ImageStyle(loaded: loaded))
  }
}
