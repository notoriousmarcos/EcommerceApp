//
//  CartViewModel.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import AppState
import Combine
import Foundation
import Mock
import ShopCore

// Protocol defining the interface for CartViewModel
public protocol CartViewModel: ObservableObject {
  // The list of cart items fetched from the server or provided by the mock handler.
  var items: [CartItemData] { get set }

  // Method to handle cart updates.
  // This method is called whenever the `cart` property changes.
  // It triggers the reloading of cart items by calling `reloadCartItems()`.
  func handleCartUpdate()

  // Method to decrease the quantity of a cart item or remove it if the quantity is 1.
  // If the quantity of the cart item is greater than 1, this method decreases the quantity by 1.
  // Otherwise, if the quantity is exactly 1, the cart item is removed from the cart.
  // This method does not directly update the `cart` property.
  // Instead, it calls the appropriate cart service methods to perform the necessary updates on the cart.
  func decreaseOrRemoveQuantityFor(_ item: CartItemData)

  // Method to increase the quantity of a cart item.
  // This method increases the quantity of the given cart item by 1.
  // This method does not directly update the `cart` property.
  // Instead, it calls the cart service method to perform the necessary update on the cart.
  func increaseQuantityFor(_ item: CartItemData)

  func removeProductFor(_ index: IndexSet)
}

public class DefaultCartViewModel: CartViewModel {
  // The cart associated with this view model.
  // Any changes to this property will trigger the `handleCartUpdate()` function.
  @Published var cart = Cart(userId: 1, date: .now, products: []) {
    didSet {
      handleCartUpdate()
    }
  }

  // The list of cart items fetched from the server or provided by the mock handler.
  @Published public var items: [CartItemData] = []

  // Dependency Injection container to resolve dependencies.
  private let container: AppContainer

  // Cart service used to perform cart-related operations.
  private let cartService: CartService

  // Optional handler for fetching product data given the product ID.
  private let getProductHandler: ((Int, @escaping GetProductUseCase.CompletionHandler) -> Void)?

  // A set of `AnyCancellable` objects used to store Combine publishers.
  // These publishers are canceled automatically when the `CartViewModel` instance is deallocated.
  private var cancellables = Set<AnyCancellable>()

  // Initialize a new `CartViewModel` instance.
  // - Parameters:
  //   - container: The dependency injection container to resolve dependencies from.
  //   - cartService: The cart service used to perform cart-related operations.
  //   - getProductHandler: An optional handler for fetching product data given the product ID.
  // If not provided, the cart items will be empty.
  public init(
    container: AppContainer,
    cartService: CartService,
    getProductHandler: ((Int, @escaping GetProductUseCase.CompletionHandler) -> Void)? = nil
  ) {
    self.container = container
    self.cartService = cartService
    self.getProductHandler = getProductHandler

    // Subscribe to changes in the app state's cart and update the local `cart` property accordingly.
    container.appState.map(\.shopCart.cart)
      .removeDuplicates()
      .assign(to: \.cart, on: self)
      .store(in: &cancellables)

    // Update the cart items when initializing the view model.
    handleCartUpdate()
  }

  // Method to handle cart updates.
  // This method is called whenever the `cart` property changes.
  // It triggers the reloading of cart items by calling `reloadCartItems()`.
  public func handleCartUpdate() {
    reloadCartItems()
  }

  // Method to decrease the quantity of a cart item or remove it if the quantity is 1.
  // If the quantity of the cart item is greater than 1, this method decreases the quantity by 1.
  // Otherwise, if the quantity is exactly 1, the cart item is removed from the cart.
  // This method does not directly update the `cart` property.
  // Instead, it calls the appropriate cart service methods to perform the necessary updates on the cart.
  public func decreaseOrRemoveQuantityFor(_ item: CartItemData) {
    if item.quantity > 1 {
      cartService.updateProduct(item.product, quantity: item.quantity - 1, cart: cart)
    } else {
      cartService.removeProduct(item.product, cart: cart)
    }
  }

  public func removeProductFor(_ index: IndexSet) {
    guard let index = index.first else { return }
    cartService.removeProduct(items[index].product, cart: cart)
  }

  // Method to increase the quantity of a cart item.
  // This method increases the quantity of the given cart item by 1.
  // This method does not directly update the `cart` property.
  // Instead, it calls the cart service method to perform the necessary update on the cart.
  public func increaseQuantityFor(_ item: CartItemData) {
    cartService.addProduct(item.product, cart: cart)
  }

  // Method to fetch the cart items for the given cart.
  // It fetches cart items from the server by using the provided `getProductHandler`
  // to fetch product data for each item in the cart.
  // The cart items are then sorted alphabetically based on their product titles.
  // If the `getProductHandler` is not provided, it returns an empty list of cart items.
  private func getCartItems(_ cart: Cart) -> AnyPublisher<[CartItemData], DomainError> {
    guard let getProductHandler = getProductHandler else {
      return Just([]).setFailureType(to: DomainError.self).eraseToAnyPublisher()
    }

    let requests = cart.products.map { item in
      Deferred {
        Future<CartItemData, DomainError> { promise in
          getProductHandler(item.productId) { result in
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

  // Method to reload the cart items.
  // It fetches the cart items for the current `cart` and updates the `items` property accordingly.
  private func reloadCartItems() {
    getCartItems(cart)
      .sink(receiveCompletion: { completion in
        switch completion {
          case .finished:
            break
          case .failure(let error):
            print("Error reloading cart items:", error.localizedDescription)
            // TODO: Handle error appropriately
        }
      }, receiveValue: { [weak self] items in
        self?.items = items.sorted { $0.product.title > $1.product.title }
      })
      .store(in: &cancellables)
  }

  // Deinitializer to clean up any resources.
  deinit { }
}
