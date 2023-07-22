//
//  ShowProductsView.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import SwiftUI

struct ShowProductsView<ViewModel: ShowProductsViewModelProtocol>: View {
  @ObservedObject var viewModel: ViewModel

  init(viewModel: ViewModel) {
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
      viewModel.fetchProducts(shouldReset: true)
    }
  }
}

//struct ShowProductsView_Previews: PreviewProvider {
//  static var previews: some View {
//    ShowProductsView(viewModel: ShowProductsViewModel(service: <#ProductsService#>))
//  }
//}
