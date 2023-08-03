//
//  ProductsView.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import SwiftUI

/// A view responsible for displaying a list of products fetched from the `ProductsViewModelProtocol`.
public struct ProductsListView<ViewModel: ProductsViewModelProtocol>: View {
  /// The view model conforming to `ProductsViewModelProtocol` responsible for managing the product data and state.
  @ObservedObject var viewModel: ViewModel

  /// Initializes the `ProductsListView` with the given view model.
  ///
  /// - Parameter viewModel: The view model conforming to `ProductsViewModelProtocol`.
  public init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    productsView()
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

  /// A helper method that creates the main content of the `ProductsListView`.
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
              VStack {
                NavigationLink {
                  // TODO: Need to inject this view in future.
                  ProductDetailView(ProductDetailViewModel(product: product))
                } label: {
                  EmptyView()
                }
                .opacity(0)

                ProductRowView(ProductViewModel(product: product))
                  .frame(maxWidth: .infinity)
              }
              .searchable(text: $viewModel.searchValue, placement: .sidebar)
              .onAppear {
                viewModel.fetchNextPage(product)
              }
              .listRowBackground(Color.backgroundColor)
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
      ProductsListView(viewModel: MockShowProductsViewModel(products: []))
      ProductsListView(viewModel: MockShowProductsViewModel(products: [], viewState: .loading))
      ProductsListView(
        viewModel: MockShowProductsViewModel(
          products: [
            ProductViewItem(
              id: 1,
              title: "Title",
              price: 2.99,
              category: .init(
                id: 1,
                name: "Category",
                imageURL: URL(string: "https://picsum.photos/640/640?r=2738")
              ),
              description: "Description",
              imagesURL: [URL(string: "https://picsum.photos/640/640?r=2738")!]
            ),
            ProductViewItem(
              id: 2,
              title: "Title2",
              price: 122.99,
              category: .init(
                id: 1,
                name: "Category",
                imageURL: URL(string: "https://picsum.photos/640/640?r=2738")
              ),
              description: "Description",
              imagesURL: [URL(string: "https://picsum.photos/640/640?r=2738")!]
            )
          ],
          viewState: .finished
        )
      )
      ProductsListView(
        viewModel: MockShowProductsViewModel(
          products: [
            ProductViewItem(
              id: 1,
              title: "Title",
              price: 2.99,
              category: .init(
                id: 1,
                name: "Category",
                imageURL: URL(string: "https://picsum.photos/640/640?r=2738")
              ),
              description: "Description",
              imagesURL: [URL(string: "https://picsum.photos/640/640?r=2738")!]
            ),
            ProductViewItem(
              id: 2,
              title: "Title2",
              price: 122.99,
              category: .init(
                id: 1,
                name: "Category",
                imageURL: URL(string: "https://picsum.photos/640/640?r=2738")
              ),
              description: "Description",
              imagesURL: [URL(string: "https://picsum.photos/640/640?r=2738")!]
            )
          ],
          viewState: .fetching
        )
      )
      ProductsListView(
        viewModel: MockShowProductsViewModel(
          products: [],
          viewState: .finished,
          error: ProductsServiceError.unknown
        )
      )
    }
  }
}
