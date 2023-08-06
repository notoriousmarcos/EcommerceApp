//
//  HomeComposer.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import HomeFeature
import SwiftUI

// MARK: - HomeComposer
extension AppView {
  var homeView: AnyView {
    AnyView(
      HomeView(viewModel: homeViewViewModel)
    )
  }

  private var homeViewViewModel: HomeViewViewModel {
    HomeViewViewModel(containter: container, topProductsContentView: { productsGridView })
  }
}
