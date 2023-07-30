//
//  CompositionRoot.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 03/07/23.
//

import Backend
import Foundation
import ProductsFeature
import SwiftUI

protocol Composer {
  associatedtype View: SwiftUI.View
  static var rootView: View { get }
}

enum CompositionRoot: Composer {
  static var rootView: ShowProductsView<ShowProductsViewModel> {
    ProductsComposer.rootView
  }

  static var productsView: ShowProductsView<ShowProductsViewModel> {
    ProductsComposer.rootView
  }

  static var httpClient: HTTPClient {
    NativeHTTPClient()
  }
}

enum ProductsComposer: Composer {
  static var rootView: ShowProductsView<ShowProductsViewModel> {
    ShowProductsView(viewModel: showProductsViewModel)
  }

  private static var showProductsViewModel: ShowProductsViewModel {
    let viewModel = ShowProductsViewModel(service: productsService, pageLimit: 15)
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
