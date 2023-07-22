//
//  ShowProductsViewModel.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import Foundation
import Combine
import Backend

class ShowProductsViewModel: ObservableObject {
  
  @Published private(set) var products: [ProductViewItem] = []
  @Published private(set) var viewState: ViewState?
  @Published private(set) var error: Error?
  private var currentOffset = 0
  private var pageLimit: Int
  
  private var cancellables = Set<AnyCancellable>()
  private let service: ProductsService
  
  init(
    service: ProductsService,
    pageLimit: Int = 10
  ) {
    self.service = service
    self.pageLimit = pageLimit
  }
  
  func fetchProducts(shouldReset: Bool = false) {
    if shouldReset {
      viewState = nil
      currentOffset = 0
    }
    fetchProductsOnService()
  }


  private func fetchProductsOnService() {
    viewState = .loading
    service
      .fetchProducts(for: currentOffset, and: pageLimit)
      .sink { [weak self] status in
        if case let .failure(error) = status {
          self?.error = error
        }
      } receiveValue: { [weak self] products in
        guard let self = self else { return }
        var productsItemView = productsToViewItem(products)
        self.products = self.currentOffset == 0 ? productsItemView : self.products + productsItemView
        self.currentOffset += self.pageLimit
        self.viewState = .finished
      }
  }

  private func productsToViewItem(_ products: [Product]) -> [ProductViewItem] {
    return products.map { product in
      ProductViewItem(
        id: product.id,
        title: product.title,
        price: product.price,
        category: CategoryItemView(
          id: product.category.id,
          name: product.category.name,
          imageURL: product.category.imageURL
        ),
        description: product.description,
        imagesURL: product.imagesURL
      )
    }
  }
}

extension ShowProductsViewModel {
  enum ViewState {
    case fetching
    case loading
    case finished
  }
}
