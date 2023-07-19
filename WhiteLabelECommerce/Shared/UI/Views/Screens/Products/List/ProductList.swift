//
//  ProductList.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Combine
import SwiftUI
import Backend

// MARK: - Movies List
struct ProductList<ViewModel: ProductListViewModelProtocol>: View {
  // MARK: - Private var
  @ObservedObject private var viewModel: ViewModel
  @State private var selectedItem: String?

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
      if viewModel.isSearching {
        Section(header: Text("Results for \(viewModel.searchTextViewModel.searchText)")) {
          if viewModel.isSearching && products.isEmpty {
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
      viewModel: viewModel.searchTextViewModel,
      placeholder: "Search any product",
      isSearching: $viewModel.isSearching
    )
  }

  // MARK: - Body
  var body: some View {
    List {
      switch viewModel.state {
        case .loaded(let items):
          if viewModel.displaySearch {
            Section {
              searchField
            }
          }

          productSection(products: items)
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
