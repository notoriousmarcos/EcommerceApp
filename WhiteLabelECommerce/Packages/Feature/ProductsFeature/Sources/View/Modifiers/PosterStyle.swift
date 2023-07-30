//
//  ImageStyle.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct ImageStyle: ViewModifier {
  enum Size {
    case small, medium, big

    func width() -> CGFloat {
      switch self {
        case .small: return 80
        case .medium: return 150
        case .big: return 375
      }
    }
    func height() -> CGFloat {
      switch self {
        case .small: return 80
        case .medium: return 150
        case .big: return 375
      }
    }
  }

  let loaded: Bool
  let size: Size

  func body(content: Content) -> some View {
    return content
      .frame(width: size.width(), height: size.height())
      .cornerRadius(5)
      .opacity(loaded ? 1 : 0.1)
      .shadow(radius: 8)
  }
}

extension View {
  func imageStyle(loaded: Bool, size: ImageStyle.Size) -> some View {
    return ModifiedContent(content: self, modifier: ImageStyle(loaded: loaded, size: size))
  }
}
