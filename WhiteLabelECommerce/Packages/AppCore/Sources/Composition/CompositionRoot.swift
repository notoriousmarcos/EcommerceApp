//
//  AppCoreComposer.swift
//  
//
//  Created by Marcos Vinicius Brito on 03/08/23.
//

import SwiftUI

import AppState
import Backend
import HomeFeature
import ProductsFeature
import RootFeature
import TabBarFeature

enum CompositionRoot {
  private static var appState: Store<AppState> = .init(AppState())

  static func setup(state: Store<AppState>) {
    appState = state
  }

  static var rootView: some View {
    RootView(
      viewModel: rootViewModel,
      welcomeViewProvider: welcomeProvider,
      tabBarViewProvider: { tabBarView }
    )
  }

  private static var rootViewModel: RootViewModel {
    RootViewModel(appState: appState)
  }

  private static func welcomeProvider() -> some View {
    AnyView(Text(""))
  }
}

// MARK: - TabBarComposer
extension CompositionRoot {
  static var tabBarView: AnyView {
    AnyView(
      TabBarView(
        providers: providers
      )
    )
  }

  private static var providers: [TabViewProvider] {
    [homeTabProvider]
  }

  static var homeTabProvider: TabViewProvider {
    TabViewProvider(
      systemImageName: "house.fill",
      tabName: "Home",
      viewProvider: { homeView }
    )
  }
}

// MARK: - HomeComposer
extension CompositionRoot {
  static var homeView: AnyView {
    AnyView(
      HomeView(viewModel: viewModel)
    )
  }

  private static var viewModel: HomeViewViewModel {
    HomeViewViewModel(searchText: .constant(""), topProductsContentView: { productsGridView })
  }
}

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

// MARK: - InfraComposr
extension CompositionRoot {
  static var httpClient: HTTPClient {
    NativeHTTPClient()
  }
}
