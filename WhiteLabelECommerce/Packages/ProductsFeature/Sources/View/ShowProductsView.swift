//
//  ShowProductsView.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import SwiftUI

struct ShowProductsView: View {
  @ObservedObject var viewModel: ShowProductsViewModel

  init(viewModel: ShowProductsViewModel) {
    self.viewModel = viewModel
  }
  var body: some View {
    NavigationView {
      List(viewModel.products, id: \.id) { product in
        Text(product.title)
      }
    }
    .navigationTitle("Products")
    .onAppear {
      viewModel.fetchProducts()
    }
  }
}

//struct ShowProductsView_Previews: PreviewProvider {
//  static var previews: some View {
//    ShowProductsView(viewModel: ShowProductsViewModel(service: <#ProductsService#>))
//  }
//}
