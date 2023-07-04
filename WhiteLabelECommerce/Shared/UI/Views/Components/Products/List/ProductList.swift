//
//  ProductList.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Combine
import SwiftUI

// MARK: - Movies List
struct ProductList<ViewModel: ListItemsViewModelProtocol>: View {

  // MARK: - binding
  @State private var searchTextWrapper = SearchTextObservable()
  @State private var isSearching = false

  // MARK: - Public var
  let displaySearch = false

  // MARK: - Private var
  @ObservedObject private var viewModel: ViewModel
  @State private var selectedItem: String?
  @State private var listViewId = UUID()

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Computed views
  private func productRows(products: [Product]) -> some View {
    ForEach(products, id: \.id) { product in
      NavigationLink(
        destination: ProductDetail(product: product),
        tag: String(product.id),
        selection: $selectedItem
      ) {
        ProductRow(product: product)
      }
    }
  }

  private func productSection(products: [Product]) -> some View {
    Group {
      if isSearching {
        Section(header: Text("Results for \(searchTextWrapper.searchText)")) {
          if isSearching && products.isEmpty {
            Text("No results")
          } else {
            productRows(products: products)
          }
        }
      } else {
        Section {
          productRows(products: products)
        }
      }
    }
  }

  private var searchField: some View {
    SearchField(
      searchTextWrapper: searchTextWrapper,
      placeholder: "Search any product",
      isSearching: $isSearching
    )
  }

  // MARK: - Body
  var body: some View {
    List {
      switch viewModel.state {
        case .loaded(let items):
          if displaySearch {
            Section {
              searchField
            }
          }

          productSection(products: items).id(listViewId)
        case .failed(let error):
          VStack {
            Text("Sorry, we get something wrong: \(error.localizedDescription)")
            Button(action: viewModel.reload, label: { Text("Retry") })
          }
        case .idle:
          Color.clear
      }
    }
    .listStyle(PlainListStyle())
    .onAppear {
      viewModel.onLoad()
      if selectedItem != nil {
        selectedItem = nil
        /// Changing view id to refresh view to avoid a bug of SwiftUI List that selected list row remains highlighted
        listViewId = UUID()
      }
    }
  }
}

#if DEBUG
struct ProductList_Previews: PreviewProvider {
  static var previews: some View {
    Text("Preview")
  }
}
#endif
