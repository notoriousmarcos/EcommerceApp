//
//  View.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 10/07/23.
//

import SwiftUI

public extension View {
  func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
#if os(iOS)
    return modifier(self)
#else
    return self
#endif
  }
}

public extension View {
  func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
#if os(macOS)
    return modifier(self)
#else
    return self
#endif
  }
}

public extension View {
  func tvOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
#if os(tvOS)
    return modifier(self)
#else
    return self
#endif
  }
}

public extension View {
  func watchOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
#if os(watchOS)
    return modifier(self)
#else
    return self
#endif
  }
}
