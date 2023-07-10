//
//  Tabbar.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import SwiftUI

// MARK: - Shared View

struct HomeView: View {
#if targetEnvironment(macCatalyst)
  var body: some View {
    SplitView().accentColor(.steamGold)
  }
#else
  var body: some View {
    TabbarView().accentColor(.steamGold)
  }
#endif
  private func setupApperance() {
#if os(iOS) || os(tvOS) || os(watchOS)
    UINavigationBar.appearance().largeTitleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor(named: "steam_gold")!,
      NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 40)!
    ]

    UINavigationBar.appearance().titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor(named: "steam_gold")!,
      NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 18)!
    ]

    UIBarButtonItem.appearance().setTitleTextAttributes(
      [
        NSAttributedString.Key.foregroundColor: UIColor(named: "steam_gold")!,
        NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 16)!
      ],
      for: .normal
    )

    UIWindow.appearance().tintColor = UIColor(named: "steam_gold")
#else
    // TODO: Implement setup apperance for macOS
#endif
  }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .environmentObject(Main.shared)
  }
}
#endif
