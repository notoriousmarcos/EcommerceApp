//
//  HomeViewViewModel.swift
//  
//
//  Created by Marcos Vinicius Brito on 02/08/23.
//

import AppState
import SwiftUI

public class HomeViewViewModel: ObservableObject {
  @Published var searchText: String = ""
  let containter: AppContainer
  let topProductsContentView: () -> AnyView

  public init(
    containter: AppContainer,
    topProductsContentView: @escaping () -> AnyView
  ) {
    self.containter = containter
    self.topProductsContentView = topProductsContentView
  }

  deinit {
  }
}
