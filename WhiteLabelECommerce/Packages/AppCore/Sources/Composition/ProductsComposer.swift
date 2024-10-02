//
//  ProductsComposer.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import AppState
import ProductsFeature
import ShopCore
import SwiftUI

// MARK: - ProductsComposer
extension AppView {
  var productsGridView: AnyView {
    AnyView(
      ProductsGridView(viewModel: productsViewModel)
    )
  }

  var productsListView: AnyView {
    AnyView(
      ProductsListView(viewModel: productsViewModel)
    )
  }

  private var productsViewModel: ProductsViewModel {
    let viewModel = ProductsViewModel(
      container: container,
      productsService: productsService,
      cartService: cartService,
      pageLimit: 15
    )
    viewModel.title = "Products"
    return viewModel
  }

  private var productsService: ShowProductsService {
    ShowProductsService(fetchProductsUseCase: shopCore.remoteGetProductsUseCase)
  }

  private var remoteGetProductClient: GetProductClient {
    RemoteGetProductClient(client: httpClient)
  }

  private var remoteGetProductsClient: GetProductsClient {
    RemoteGetProductsClient(client: httpClient)
  }
}
