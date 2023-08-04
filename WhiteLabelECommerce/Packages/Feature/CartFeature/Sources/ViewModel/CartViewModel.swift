//
//  CartViewModel.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import Combine
import Foundation
import Backend
import Mock
import AppState

public class CartViewModel: ObservableObject {
  @Published var cart: Cart
  @Published var items: [CartItemData] = []
  private var cartService: CartService
  private var appState: Store<AppState>

  /// A set of `AnyCancellable` objects used to store Combine publishers. These publishers are
  /// canceled automatically when the `CartViewModel` instance is deallocated,
  /// preventing potential memory leaks.
  private var cancellables = Set<AnyCancellable>()

  public init(cartService: CartService, appState: Store<AppState>) {
    self.cartService = cartService
    self.cart = appState.value.shopCart.cart
    self.appState = appState
  }

  func onAppear() {
    appState.map(\.shopCart.cart)
      .removeDuplicates()
      .assign(to: \.cart, on: self)
      .store(in: &cancellables)

    cartService.getCartItems(cart)
      .sink { res in
        // TODO: - Deal with errors
      } receiveValue: { [weak self] items in
        self?.items = items
      }
      .store(in: &cancellables)

  }

  func decreaseOrRemoveQuantityFor(_ item: CartItemData) {
    cartService.addProduct(item.product)
  }

  func increaseQuantityFor(_ item: CartItemData) {
//    cart.products[getItemIndex(item)].quantity += 1
  }

  deinit { }
}
