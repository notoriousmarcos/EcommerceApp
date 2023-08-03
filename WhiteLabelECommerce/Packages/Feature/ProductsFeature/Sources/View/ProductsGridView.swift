//
//  SwiftUIView.swift
//  
//
//  Created by Marcos Vinicius Brito on 02/08/23.
//

import NotoriousComponentsKit
import SwiftUI

public struct ProductsGridView<ViewModel: ProductsViewModelProtocol>: View {
  /// The view model conforming to `ProductsViewModelProtocol` responsible for managing the product data and state.
  @ObservedObject var viewModel: ViewModel
  
  /// Initializes the `ProductsGridView` with the given view model.
  ///
  /// - Parameter viewModel: The view model conforming to `ProductsViewModelProtocol`.
  public init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    productsView()
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
            LazyVGrid(
              columns: Array(
                repeating: GridItem(.flexible(), spacing: 12, alignment: .topLeading),
                count: 2
              )
            ) {
              ForEach(viewModel.products, id: \.id) { product in
                NavigationLink {
                  // TODO: Need to inject this view in future.
                  ProductDetailView(ProductDetailViewModel(product: product))
                } label: {
                  ProductGridItemView(ProductViewModel(product: product))
                    .frame(height: 240)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 16)
                .onTapGesture {
                  viewModel.selectedProduct = product
                }
                .onAppear {
                  viewModel.fetchNextPage(product)
                }
              } //: ForEach
            } //: LazyGrid
            .frame(maxWidth: .infinity)
          default:
            EmptyView()
        }
      }
    }
  }
}

struct ProductsGridView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ProductsGridView(viewModel: MockShowProductsViewModel(products: []))
        .previewLayout(.sizeThatFits)
      ProductsGridView(viewModel: MockShowProductsViewModel(products: [], viewState: .loading))
      ProductsGridView(
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
            ),
            ProductViewItem(
              id: 3,
              title: "Title2",
              price: 122.99,
              category: .init(
                id: 1,
                name: "Category",
                imageURL: URL(string: "https://picsum.photos/640/640?r=2738")
              ),
              description: "Description",
              imagesURL: [URL(string: "https://picsum.photos/640/640?r=2738")!]
            ),
            ProductViewItem(
              id: 4,
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
      ProductsGridView(
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
      ProductsGridView(
        viewModel: MockShowProductsViewModel(
          products: [],
          viewState: .finished,
          error: ProductsServiceError.unknown
        )
      )
    }
  }
}
