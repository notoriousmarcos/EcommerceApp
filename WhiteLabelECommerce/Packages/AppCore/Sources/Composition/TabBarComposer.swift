//
//  TabBarComposer.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import SwiftUI
import TabBarFeature

// MARK: - TabBarComposer
extension AppView {
  var tabBarView: AnyView {
    AnyView(
      TabBarView(
        providers: providers
      )
    )
  }

  private var providers: [TabViewProvider] {
    [
      homeTabProvider,
      myCartTabProvider
    ]
  }

  private var homeTabProvider: TabViewProvider {
    TabViewProvider(
      systemImageName: "house.fill",
      tabName: "Home",
      viewProvider: { homeView }
    )
  }

  private var myCartTabProvider: TabViewProvider {
    TabViewProvider(
      systemImageName: "cart.fill",
      tabName: "My Cart",
      viewProvider: { cartView }
    )
  }
}
