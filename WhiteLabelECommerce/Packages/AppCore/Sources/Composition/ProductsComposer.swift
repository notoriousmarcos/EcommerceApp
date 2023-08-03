//
//  ProductsComposer.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import SwiftUI
import ProductsFeature
import Backend
import AppState

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

  private static var remoteGetProductsClient: GetProductsClient {
    RemoteGetProductsClient(client: CompositionRoot.httpClient)
  }

  private static var cartService: CartService {
    DefaultCartService { product in
      addProductToCartUseCase.execute(product, toCart: appState.value.shopCart.cart) { result in
        switch result {
          case .success(let cart):
            appState.bulkUpdate { state in
              state.shopCart.cart = cart
            }
          case .failure:
            break
        }
      }
    }
  }

  private static var addProductToCartUseCase: AddProductToCartUseCase {
    LocalAddProductToCartUseCase()
  }
}
