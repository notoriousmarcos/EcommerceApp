//
//  HomeViewViewModel.swift
//  
//
//  Created by Marcos Vinicius Brito on 02/08/23.
//

import SwiftUI

public class HomeViewViewModel: ObservableObject {
  let searchText: Binding<String>
  let topProductsContentView: () -> AnyView

  public init(
    searchText: Binding<String>,
    topProductsContentView: @escaping () -> AnyView
  ) {
    self.searchText = searchText
    self.topProductsContentView = topProductsContentView
  }

  deinit {

  }
}
