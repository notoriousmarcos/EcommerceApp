//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import Backend
import CartFeature
import SwiftUI

// MARK: - CartComposer
extension CompositionRoot {
  static var cartView: AnyView {
    AnyView(
      CartView(viewModel: viewModel)
    )
  }

  private static var viewModel: CartViewModel {
    CartViewModel(
      cartService: cartService,
      appState: appState,
      getProductUseCase: getProductUseCase
    )
  }

  static var cartService: CartService {
    DefaultCartService(
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
      }, updateProductHandler: { product, quantity in
        updateProductToCartUseCase.execute(
          product,
          withQuantity: quantity,
          inCart: appState.value.shopCart.cart
        ) { result in
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
      }
    )
  }

  static var addProductToCartUseCase: AddProductToCartUseCase {
    LocalAddProductToCartUseCase()
  }

  static var updateProductToCartUseCase: UpdateProductInCartUseCase {
    LocalUpdateProductInCartUseCase()
  }

  static var removeProductToCartUseCase: RemoveProductInCartUseCase {
    LocalRemoveProductInCartUseCase()
  }
}
