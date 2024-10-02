//
//  ShowProductsViewModel.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import AppState
import CartFeature
import Combine
import Foundation
import ShopCore

public protocol ProductsViewModelProtocol: ObservableObject {
  // MARK: - Properties
  var title: String { get set }
  var searchValue: String { get set }
  var products: [Product] { get }
  var selectedProduct: Product? { get set }
  var viewState: ProductsViewModel.ViewState? { get }
  var error: Error? { get }

  // MARK: - Methods
  func addToCart(_ product: Product)
  func fetchProducts(shouldReset: Bool)
  func fetchNextPage(_ product: Product)
}

public final class ProductsViewModel: ProductsViewModelProtocol {
  // MARK: - Properties

  /// An array of `Product` objects that represent the products fetched from the service and
  /// ready for presentation in the UI.
  @Published public var title: String = "Products"

  /// An array of `Product` objects that represent the products fetched from the service and
  /// ready for presentation in the UI.
  @Published public private(set) var products: [Product] = []

  @Published public var selectedProduct: Product?

  /// The current state of the product fetching process, which can be `.fetching`, `.loading`, or `.finished`.
  @Published public private(set) var viewState: ViewState?

  /// An optional `Error` object that holds any error encountered during the product fetching process. If nil,
  /// it indicates no errors occurred.
  @Published public private(set) var error: Error?

  public var searchValue: String = "" {
    didSet {
      // TODO: Implement searchable.
//      service.fetchProducts(for: <#T##Int?#>, andLimit: <#T##Int?#>)
    }
  }

  let container: AppContainer

  /// The current offset/index for pagination. It is used to request products from the service with
  /// the appropriate offset.
  private var currentOffset = 0

  /// The maximum number of products to be fetched in a single API call. This value is used for pagination to
  /// limit the number of products returned in each request.
  private var pageLimit: Int

  /// A set of `AnyCancellable` objects used to store Combine publishers. These publishers are
  /// canceled automatically when the `ShowProductsViewModel` instance is deallocated,
  /// preventing potential memory leaks.
  private var cancellables = Set<AnyCancellable>()

  /// An instance of `ProductsService`, which is a service responsible for fetching product data from the backend or
  /// any external data source.
  private let productsService: ProductsService

  /// An instance of `CartService`, which is a service responsible for fetching product data from the backend or
  /// any external data source.
  private let cartService: CartService

  // MARK: - Initializer
  /// Initializes the `ShowProductsViewModel` with the provided `ProductsService` instance and an optional `pageLimit`.
  ///
  /// - Parameters:
  ///   - productsService: An instance of `ProductsService` used for fetching products.
  ///   - pageLimit: The maximum number of products to fetch in each API call. Default value is 10.
  public init(
    container: AppContainer,
    productsService: ProductsService,
    cartService: CartService,
    pageLimit: Int = 10
  ) {
    self.container = container
    self.productsService = productsService
    self.cartService = cartService
    self.pageLimit = pageLimit
  }

  // MARK: - Public Methods

  public func addToCart(_ product: Product) {
    cartService.addProduct(product, cart: container.appState.value.shopCart.cart)
  }

  /// Initiates the process of fetching products.
  ///
  /// - Parameter shouldReset: A boolean value indicating whether to reset the fetch process.
  /// If `true`, the `viewState` and `currentOffset` properties are reset before initiating the fetch process.
  /// Default value is `false`.
  public func fetchProducts(shouldReset: Bool = false) {
    guard viewState != .loading else { return }
    if shouldReset {
      currentOffset = 0
      viewState = .loading
    } else {
      viewState = .fetching
    }
    fetchProductsOnService()
  }

  public func fetchNextPage(_ product: Product) {
    guard
      let lastIndex = products.lastIndex(where: { $0 == product }),
      lastIndex == products.count - 4
    else { return }
    fetchProducts(shouldReset: false)
  }

  // MARK: - Private Methods
  /// Fetches products from the service and updates the view state accordingly.
  private func fetchProductsOnService() {
    productsService
      .fetchProducts(for: currentOffset, andLimit: pageLimit)
      .sink { [weak self] status in
        if case let .failure(error) = status {
          self?.error = error
        }
        self?.viewState = .finished
      } receiveValue: { [weak self] products in
        guard let self = self else { return }
        self.products = self.currentOffset == 0 ? products : self.products + products
        self.currentOffset += self.pageLimit
      }
      .store(in: &cancellables)
  }

  deinit {
#if DEBUG
    // print("Deinit \(Self.self)")
#endif
  }
}

// MARK: - ViewState
public extension ProductsViewModel {
  /// Represents the various states of the product fetching process.
  enum ViewState {
    /// Indicates that products are currently being fetched.
    case fetching

    /// Indicates that the product fetching process is loading.
    case loading

    /// Indicates that the product fetching process has finished.
    case finished
  }
}

/// A mock implementation of `ShowProductsViewModelProtocol` used for previews and testing purposes.
internal class MockShowProductsViewModel: ProductsViewModelProtocol {
  var title: String
  var products: [Product]
  var selectedProduct: Product?
  var viewState: ProductsViewModel.ViewState?
  var error: Error?
  var searchValue: String

  init(
    title: String = "",
    products: [Product],
    viewState: ProductsViewModel.ViewState? = nil,
    error: Error? = nil,
    searchValue: String = ""
  ) {
    self.title = title
    self.products = products
    self.viewState = viewState
    self.error = error
    self.searchValue = searchValue
  }

  func addToCart(_ product: Product) { }

  func fetchProducts(shouldReset: Bool) { }

  func fetchNextPage(_ product: Product) { }
}
