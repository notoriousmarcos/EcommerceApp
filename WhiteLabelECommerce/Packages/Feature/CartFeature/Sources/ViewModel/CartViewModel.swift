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
  @Published var cart = Cart(userId: 1, date: .now, products: []) {
    didSet {
      reload()
    }
  }
  @Published var items: [CartItemData] = []
  private var cartService: CartService

  /// A set of `AnyCancellable` objects used to store Combine publishers. These publishers are
  /// canceled automatically when the `CartViewModel` instance is deallocated,
  /// preventing potential memory leaks.
  private var cancellables = Set<AnyCancellable>()

  public init(cartService: CartService, appState: Store<AppState>) {
    self.cartService = cartService
    appState.map(\.shopCart.cart)
      .removeDuplicates()
      .assign(to: \.cart, on: self)
      .store(in: &cancellables)
  }

  func reload() {
    cartService.getCartItems(cart)
      .sink { res in
        // TODO: - Deal with errors
      } receiveValue: { [weak self] items in
        self?.items = items.sorted { $0.product.title > $1.product.title }
      }
      .store(in: &cancellables)
  }

  func decreaseOrRemoveQuantityFor(_ item: CartItemData) {
    item.quantity > 1 ? cartService.updateProduct(item, quantity: item.quantity - 1) :
                        cartService.removeProduct(item)
  }

  func increaseQuantityFor(_ item: CartItemData) {
    cartService.addProduct(item)
  }

  deinit { }
}
