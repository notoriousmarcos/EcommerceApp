//
//  HomeComposer.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import HomeFeature
import SwiftUI

// MARK: - HomeComposer
extension CompositionRoot {
  static var homeView: AnyView {
    AnyView(
      HomeView(viewModel: viewModel)
    )
  }

  private static var viewModel: HomeViewViewModel {
    HomeViewViewModel(searchText: .constant(""), topProductsContentView: { productsGridView })
  }
}
