//
//  ShowProductsViewModel.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import Backend
import Combine
import Foundation

public protocol ShowProductsViewModelProtocol: ObservableObject {
  // MARK: - Properties
  var searchValue: String { get set }
  var products: [ProductViewItem] { get }
  var viewState: ShowProductsViewModel.ViewState? { get }
  var error: Error? { get }

  // MARK: - Methods
  func fetchProducts(shouldReset: Bool)
  func fetchNextPage(_ product: ProductViewItem)
}

public final class ShowProductsViewModel: ShowProductsViewModelProtocol {
  // MARK: - Properties
  /// An array of `ProductViewItem` objects that represent the products fetched from the service and
  /// ready for presentation in the UI.
  @Published public private(set) var products: [ProductViewItem] = []

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
  private let service: ProductsService

  // MARK: - Initializer
  /// Initializes the `ShowProductsViewModel` with the provided `ProductsService` instance and an optional `pageLimit`.
  ///
  /// - Parameters:
  ///   - service: An instance of `ProductsService` used for fetching products.
  ///   - pageLimit: The maximum number of products to fetch in each API call. Default value is 10.
  public init(
    service: ProductsService,
    pageLimit: Int = 10
  ) {
    self.service = service
    self.pageLimit = pageLimit
  }

  // MARK: - Public Methods
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

  public func fetchNextPage(_ product: ProductViewItem) {
    guard
      let lastIndex = products.lastIndex(where: { $0 == product }),
      lastIndex == products.count - 4
    else { return }
    fetchProducts(shouldReset: false)
  }

  // MARK: - Private Methods
  /// Fetches products from the service and updates the view state accordingly.
  private func fetchProductsOnService() {
    service
      .fetchProducts(for: currentOffset, andLimit: pageLimit)
      .sink { [weak self] status in
        if case let .failure(error) = status {
          self?.error = error
        }
        self?.viewState = .finished
      } receiveValue: { [weak self] products in
        guard let self = self else { return }
        let productsItemView = self.productsToViewItem(products)
        self.products = self.currentOffset == 0 ? productsItemView : self.products + productsItemView
        self.currentOffset += self.pageLimit
      }
      .store(in: &cancellables)
  }

  /// Converts an array of `Product` objects into an array of `ProductViewItem` objects.
  ///
  /// - Parameter products: The array of `Product` objects to be converted.
  /// - Returns: An array of `ProductViewItem` objects.
  private func productsToViewItem(_ products: [Product]) -> [ProductViewItem] {
    return products.map { product in
      ProductViewItem(
        id: product.id,
        title: product.title,
        price: product.price,
        category: CategoryItemView(
          id: product.category.id,
          name: product.category.name,
          imageURL: URL(string: product.category.imageURL ?? "")
        ),
        description: product.description,
        imagesURL: product.imagesURL.compactMap { URL(string: $0 ) }
      )
    }
  }
}

// MARK: - Nested Enum
public extension ShowProductsViewModel {
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
