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

protocol Root {
  associatedtype View: SwiftUI.View
  static var rootView: View { get }
}

enum CompositionRoot: Root {
  static var rootView: ShowProductsView<ShowProductsViewModel> {
    ProductsCompositionRoot.rootView
  }

  static var httpClient: HTTPClient {
    NativeHTTPClient()
  }
}

enum ProductsCompositionRoot: Root {
  static var rootView: ShowProductsView<ShowProductsViewModel> {
    ShowProductsView(viewModel: showProductsViewModel)
  }

  private static var showProductsViewModel: ShowProductsViewModel {
    ShowProductsViewModel(service: productsService, pageLimit: 15)
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
