//
//  SwiftUIView.swift
//  
//
//  Created by Marcos Vinicius Brito on 02/08/23.
//

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
    LazyVGrid(
      columns: Array(
        repeating: GridItem(.flexible(), spacing: 16, alignment: .topLeading),
        count: 2
      )
    ) {
      ForEach(0..<40) { index in
        VStack {
          VStack(spacing: 4) {
            Image(systemName: "beats.headphones")
              .resizable()
              .frame(minHeight: 110)

            HStack {
              VStack(alignment: .leading, spacing: 4) {
                Text("Headphone title")
                  .fontWeight(.medium)
                  .foregroundColor(.primary)
                  .font(.subheadline)
                  .multilineTextAlignment(.leading)
                  .lineLimit(2)
                Text("$574.34")
                  .font(.title3)
                  .fontWeight(.semibold)
                  .multilineTextAlignment(.leading)

              }
              .frame(maxWidth: .infinity)

              VStack(alignment: .trailing) {
                Spacer()
                ZStack {
                  Color.secondaryColor

                  Button {
                    // TODO: - Action
                  } label: {
                    Image(systemName: "arrow.forward")
                      .foregroundColor(.white)
                  }
                }
                .frame(width: 40, height: 40)
                .cornerRadius(20)
              }
              .padding(.horizontal, 4)
              .frame(minHeight: 60)
            } //: HStack
            .frame(maxWidth: .infinity)

            Spacer(minLength: 4)

          } //: VStack
          .background(Color.backgroundColor)
          .cornerRadius(12)
          .padding(.vertical, 4)
          .shadow(color: .gray, radius: 1)

        } //: VStack
      } //: ForEach
    } //: LazyGrid
  }
}

struct ProductsGridView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ProductsGridView(viewModel: MockShowProductsViewModel(products: []))
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
