//
//  CartViewModel.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import AppState
import ShopCore
import Combine
import Foundation
import Mock

public class CartViewModel: ObservableObject {
  @Published var cart = Cart(userId: 1, date: .now, products: []) {
    didSet {
      reload()
    }
  }
  @Published var items: [CartItemData] = []
  private var cartService: CartService
  private var getProductUseCase: GetProductUseCase

  /// A set of `AnyCancellable` objects used to store Combine publishers. These publishers are
  /// canceled automatically when the `CartViewModel` instance is deallocated,
  /// preventing potential memory leaks.
  private var cancellables = Set<AnyCancellable>()

  public init(
    cartService: CartService,
    appState: Store<AppState>,
    getProductUseCase: GetProductUseCase
  ) {
    self.cartService = cartService
    self.getProductUseCase = getProductUseCase
    appState.map(\.shopCart.cart)
      .removeDuplicates()
      .assign(to: \.cart, on: self)
      .store(in: &cancellables)
  }

  func reload() {
    getCartItems(cart)
      .sink { _ in
        // TODO: - Deal with errors
      } receiveValue: { [weak self] items in
        self?.items = items.sorted { $0.product.title > $1.product.title }
      }
      .store(in: &cancellables)
  }

  func decreaseOrRemoveQuantityFor(_ item: CartItemData) {
    if item.quantity > 1 {
      cartService.updateProduct(item.product, quantity: item.quantity - 1)
    } else {
      cartService.removeProduct(item.product)
    }
  }

  func increaseQuantityFor(_ item: CartItemData) {
    cartService.addProduct(item.product)
  }

  func getCartItems(_ cart: Cart) -> AnyPublisher<[CartItemData], DomainError> {
    let requests = cart.products.map { item in
      Deferred {
        Future<CartItemData, DomainError> { [weak self] promise in
          self?.getProductUseCase.execute(id: item.productId) { result in
            switch result {
              case .success(let product):
                promise(.success(CartItemData(product: product, quantity: item.quantity)))
              case .failure(let error):
                promise(.failure(error))
            }
          }
        }
      }
      .eraseToAnyPublisher()
    }

    return Publishers.MergeMany(requests)
      .collect()
      .eraseToAnyPublisher()
  }

  deinit { }
}
