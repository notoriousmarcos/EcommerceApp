//
//  TabBarComposer.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import SwiftUI
import TabBarFeature

// MARK: - TabBarComposer
extension CompositionRoot {
  static var tabBarView: AnyView {
    AnyView(
      TabBarView(
        providers: providers
      )
    )
  }

  private static var providers: [TabViewProvider] {
    [
      homeTabProvider,
      myCartTabProvider
    ]
  }

  static var homeTabProvider: TabViewProvider {
    TabViewProvider(
      systemImageName: "house.fill",
      tabName: "Home",
      viewProvider: { homeView }
    )
  }

  static var myCartTabProvider: TabViewProvider {
    TabViewProvider(
      systemImageName: "cart.fill",
      tabName: "My Cart",
      viewProvider: { cartView }
    )
  }
}
