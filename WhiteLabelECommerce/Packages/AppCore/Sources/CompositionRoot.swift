//
//  AppCoreComposer.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import SwiftUI

import AppState
import ShopCore
import HomeFeature
import ProductsFeature
import RootFeature
import TabBarFeature

enum CompositionRoot {
  static var appState: Store<AppState> = .init(AppState())

  static func setup(state: Store<AppState>) {
    appState = state
  }

  static var rootView: some View {
    RootView(
      viewModel: rootViewModel,
      welcomeViewProvider: welcomeProvider,
      tabBarViewProvider: { tabBarView }
    )
  }

  private static var rootViewModel: RootViewModel {
    RootViewModel(appState: appState)
  }

  private static func welcomeProvider() -> some View {
    AnyView(Text(""))
  }
}
