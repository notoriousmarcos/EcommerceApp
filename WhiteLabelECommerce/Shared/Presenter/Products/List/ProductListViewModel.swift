//
//  ListItemsViewModel.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 29/12/22.
//

import Combine
import Foundation

protocol ProductListViewModelProtocol: ObservableObject {
  typealias FetchAllItems = (@escaping ResultCompletionHandler<[Product], DomainError>) -> Void

  var state: ViewState<[Product], DomainError> { get }
  var searchTextViewModel: SearchTextViewModel { get }
  var isSearching: Bool { get set }
  var selectedItem: String? { get }
  var displaySearch: Bool { get }

  init(fetchAllItems: @escaping FetchAllItems)

  func onLoad()

  func reload()

  func searchFor(_ text: String)
}

class ProductListViewModel: ProductListViewModelProtocol {
  // MARK: - Public Properties
  @Published private(set) var state: ViewState<[Product], DomainError> = .idle

  lazy var searchTextViewModel = SearchTextViewModel(onUpdateText: searchFor)
  var isSearching = false
  var selectedItem: String?
  let displaySearch = true

  // MARK: - Private Properties
  private let fetchAllItems: FetchAllItems
  private var fetchedProducts: [Product] = []

  // MARK: - Init
  required init(fetchAllItems: @escaping FetchAllItems) {
    self.fetchAllItems = fetchAllItems
  }

  deinit { }

  // MARK: - Functions
  func onLoad() {
    fetchItems()
  }

  func reload() {
    fetchItems()
  }

  func searchFor(_ text: String) {
    guard !text.isEmpty else {
      state = .loaded(fetchedProducts)
      return
    }

    state = .loaded(fetchedProducts.filter { $0.title.contains(text) })
  }

  // MARK: - Private Functions
  private func fetchItems() {
    guard !isSearching else { return }
    fetchAllItems { [weak self] result in
      switch result {
        case.success(let products):
          self?.fetchedProducts = products
          self?.state = .loaded(products)
        case .failure(let error):
          self?.state = .failed(error)
      }
    }
  }
}
