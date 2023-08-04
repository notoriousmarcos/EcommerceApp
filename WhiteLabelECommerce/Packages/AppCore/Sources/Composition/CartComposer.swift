//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import CartFeature
import Backend
import SwiftUI

// MARK: - CartComposer
extension CompositionRoot {
  static var cartView: AnyView {
    AnyView(
      CartView(viewModel: viewModel)
    )
  }

  private static var viewModel: CartViewModel {
    CartViewModel(cartService: cartService, appState: appState)
  }

  private static var cartService: CartService {
    CartService(
      addProductHandler: { product in
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
    },
      removeProductHandler: { product in
        removeProductToCartUseCase.execute(product, inCart: appState.value.shopCart.cart) { result in
          switch result {
            case .success(let cart):
              appState.bulkUpdate { state in
                state.shopCart.cart = cart
              }
            case .failure:
              break
          }
        }
    },
      getProductUseCase: getProductUseCase
    )
  }

  static var addProductToCartUseCase: AddProductToCartUseCase {
    LocalAddProductToCartUseCase()
  }

  static var removeProductToCartUseCase: RemoveProductInCartUseCase {
    LocalRemoveProductInCartUseCase()
  }
}
