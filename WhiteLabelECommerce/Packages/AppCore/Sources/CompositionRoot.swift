//
//  CompositionRoot.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 03/07/23.
//

import Backend
import Foundation
import ProductsFeature
import HomeFeature
import SwiftUI

protocol Composer {
  static var rootView: AnyView { get }
}

enum CompositionRoot: Composer {
  static var rootView: AnyView {
    HomeComposer.rootView
  }

  static var productsView: AnyView {
    ProductsComposer.rootView
  }

  static var httpClient: HTTPClient {
    NativeHTTPClient()
  }
}

enum HomeComposer: Composer {

  static var rootView: AnyView {
    AnyView(
      HomeView(viewModel: viewModel)
    )
  }

  static var viewModel: HomeViewViewModel {
    HomeViewViewModel(searchText: .constant("")) {
      ProductsComposer.rootView
    }
  }
}

enum ProductsComposer: Composer {
  static var rootView: AnyView {
    AnyView(Self.productsGridView)
  }

  static var productsGridView: ProductsGridView<ProductsViewModel> {
    ProductsGridView(viewModel: productsViewModel)
  }

  static var productsListView: ProductsListView<ProductsViewModel> {
    ProductsListView(viewModel: productsViewModel)
  }

  private static var productsViewModel: ProductsViewModel {
    let viewModel = ProductsViewModel(service: productsService, pageLimit: 15)
    viewModel.title = "Products"
    return viewModel
  }

  private static var productsService: ShowProductsService {
    ShowProductsService(fetchProductsUseCase: getProductsUseCase)
  }

  private static var getProductsUseCase: GetProductsUseCase {
    RemoteGetProductsUseCase(client: remoteGetProductsClient)
  }

  private static var remoteGetProductsClient: GetProductsClient {
    RemoteGetProductsClient(client: CompositionRoot.httpClient)
  }
}
