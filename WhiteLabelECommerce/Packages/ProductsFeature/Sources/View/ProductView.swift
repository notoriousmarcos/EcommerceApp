//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import SwiftUI

struct ProductView: View {
  // MARK: - Constants
  private enum Constants {
    static let leadingTrailingPadding: CGFloat = 16
    static let topBottomPadding: CGFloat = 16
    static let titleFont: Font = .system(.title2, design: .rounded)
    static let descriptionFont: Font = .system(.caption, design: .rounded)
    static let priceFont: Font = .system(.headline, design: .rounded)
    static let viewMaxHeight: CGFloat = 112
  }

  // MARK: - Properties
  @ObservedObject private var viewModel: ProductViewModel

  init(_ viewModel: ProductViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body
  var body: some View {
    ZStack {
      HStack(alignment: .center, spacing: 16) {
        if let imageURL = viewModel.product.imagesURL.first {
          PosterImage(url: imageURL, size: .small)
            .scaledToFit()
        }

        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Text(viewModel.product.title)
              .font(Constants.titleFont)
              .multilineTextAlignment(.leading)
              .lineLimit(1)
            Spacer()
          }

          HStack {
            Text(viewModel.product.description)
              .font(Constants.descriptionFont)
              .multilineTextAlignment(.leading)
            Spacer()
          }

          HStack {
            Spacer()
            Text(viewModel.productPrice())
              .font(Constants.priceFont)
              .multilineTextAlignment(.trailing)
          }
        }
        .frame(maxWidth: .infinity)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: Constants.viewMaxHeight)
  }
}

struct ProductView_Previews: PreviewProvider {
  static var previews: some View {
    ProductView(
      ProductViewModel(
        product: ProductViewItem(
          id: 1,
          title: "Title",
          price: 12222.99,
          category: .init(
            id: 1,
            name: "Category",
            imageURL: URL(string: "https://picsum.photos/640/640?r=2738")
          ),
          description: "Description",
          imagesURL: [URL(string: "https://picsum.photos/640/640?r=2738")!]
        )
      )
    )
    .frame(width: .infinity, height: 112, alignment: .center)
  }
}
