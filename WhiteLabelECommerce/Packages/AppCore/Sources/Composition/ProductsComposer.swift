//
//  ProductsComposer.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import AppState
import ShopCore
import ProductsFeature
import SwiftUI

// MARK: - ProductsComposer
extension CompositionRoot {
  static var productsGridView: AnyView {
    AnyView(
      ProductsGridView(viewModel: productsViewModel)
    )
  }

  static var productsListView: AnyView {
    AnyView(
      ProductsListView(viewModel: productsViewModel)
    )
  }

  static var getProductUseCase: GetProductUseCase {
    RemoteGetProductUseCase(client: remoteGetProductClient)
  }

  private static var productsViewModel: ProductsViewModel {
    let viewModel = ProductsViewModel(productsService: productsService, cartService: cartService, pageLimit: 15)
    viewModel.title = "Products"
    return viewModel
  }

  private static var productsService: ShowProductsService {
    ShowProductsService(fetchProductsUseCase: getProductsUseCase)
  }

  private static var getProductsUseCase: GetProductsUseCase {
    RemoteGetProductsUseCase(client: remoteGetProductsClient)
  }

  private static var remoteGetProductClient: GetProductClient {
    RemoteGetProductClient(client: CompositionRoot.httpClient)
  }

  private static var remoteGetProductsClient: GetProductsClient {
    RemoteGetProductsClient(client: CompositionRoot.httpClient)
  }
}
