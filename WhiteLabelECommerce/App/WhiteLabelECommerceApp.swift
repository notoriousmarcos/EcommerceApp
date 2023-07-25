//
//  WhiteLabelECommerceApp.swift
//  Shared
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import ProductsFeature
import SwiftUI

@main
struct WhiteLabelECommerceApp: App {
  var body: some Scene {
    WindowGroup {
      CompositionRoot.showProductsView
#if targetEnvironment(macCatalyst)
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
#endif
    }
  }
}

#if targetEnvironment(macCatalyst)
extension UIApplication {
  func addTapGestureRecognizer() {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first
    else { return }
    let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
    tapGesture.requiresExclusiveTouchType = false
    tapGesture.cancelsTouchesInView = false
    tapGesture.delegate = self
    window.addGestureRecognizer(tapGesture)
  }
}

extension UIApplication: UIGestureRecognizerDelegate {
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return true // set to `false` if you don't want to detect tap during other gestures
  }
}
#endif
