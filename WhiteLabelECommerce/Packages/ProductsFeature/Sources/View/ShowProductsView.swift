//
//  ShowProductsView.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import SwiftUI

/// A view responsible for displaying a list of products fetched from the `ShowProductsViewModelProtocol`.
struct ShowProductsView<ViewModel: ShowProductsViewModelProtocol>: View {
  /// The view model conforming to `ShowProductsViewModelProtocol` responsible for managing the product data and state.
  @ObservedObject var viewModel: ViewModel

  /// Initializes the `ShowProductsView` with the given view model.
  ///
  /// - Parameter viewModel: The view model conforming to `ShowProductsViewModelProtocol`.
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    ZStack {
      NavigationView {
        productsView()
          .navigationTitle("Products")
      }
      .refreshable {
        viewModel.fetchProducts(shouldReset: true)
      }
      .overlay(alignment: .bottom) {
        if viewModel.viewState == .fetching {
          ProgressView()
        }
      }
      .onAppear {
        viewModel.fetchProducts(shouldReset: true)
      }
    }
  }

  /// A helper method that creates the main content of the `ShowProductsView`.
  ///
  /// - Returns: A SwiftUI `View` representing the main content of the view.
  private func productsView() -> some View {
    ZStack {
      if let error = viewModel.error {
        Text(error.localizedDescription)
      } else {
        switch viewModel.viewState {
          case .loading:
            ProgressView()
              .scaledToFit()
          case .finished, .fetching:
            List(viewModel.products, id: \.id) { product in
              Text(product.title)
            }
          default:
            EmptyView()
        }
      }
    }
  }
}

struct ShowProductsView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ShowProductsView(viewModel: MockShowProductsViewModel(products: []))
      ShowProductsView(viewModel: MockShowProductsViewModel(products: [], viewState: .loading))
      ShowProductsView(
        viewModel: MockShowProductsViewModel(
          products: [
            ProductViewItem(
              id: 1,
              title: "Title",
              price: 2.99,
              category: .init(
                id: 1,
                name: "Category",
                imageURL: "https://picsum.photos/640/640?r=2738"
              ),
              description: "Description",
              imagesURL: ["https://picsum.photos/640/640?r=2738"]
            )
          ],
          viewState: .finished
        )
      )
      ShowProductsView(
        viewModel: MockShowProductsViewModel(
          products: [
            ProductViewItem(
              id: 1,
              title: "Title",
              price: 2.99,
              category: .init(
                id: 1,
                name: "Category",
                imageURL: "https://picsum.photos/640/640?r=2738"
              ),
              description: "Description",
              imagesURL: ["https://picsum.photos/640/640?r=2738"]
            )
          ],
          viewState: .fetching
        )
      )
      ShowProductsView(viewModel: MockShowProductsViewModel(products: [], viewState: .finished, error: ShowProductsServiceError.unknown))
    }
  }
}

/// A mock implementation of `ShowProductsViewModelProtocol` used for previews and testing purposes.
private class MockShowProductsViewModel: ShowProductsViewModelProtocol {
  var products: [ProductViewItem]
  var viewState: ShowProductsViewModel.ViewState?
  var error: Error?

  init(products: [ProductViewItem], viewState: ShowProductsViewModel.ViewState? = nil, error: Error? = nil) {
    self.products = products
    self.viewState = viewState
    self.error = error
  }

  func fetchProducts(shouldReset: Bool) { }
}
