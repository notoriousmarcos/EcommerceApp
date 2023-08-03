//
//  ProductView.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Mock
import NotoriousComponentsKit
import SwiftUI

struct ProductRowView: View {
  // MARK: - Constants
  private enum Constants {
    static let leadingTrailingPadding: CGFloat = 16
    static let topBottomPadding: CGFloat = 16
    static let viewMaxHeight: CGFloat = 112
  }

  // MARK: - Properties
  @ObservedObject private var viewModel: ProductViewModel

  init(_ viewModel: ProductViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      // MARK: - Image
      if let imageURL = viewModel.product.imagesURL.first, let url = URL(string: imageURL) {
        PrettyImage(url: url)
          .frame(width: 80, height: 80)
      }

      // MARK: - Row Content
      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Text(viewModel.product.title)
            .textFont(size: 16)
            .foregroundColor(.primaryColor)
            .multilineTextAlignment(.leading)
            .lineLimit(1)
          Spacer()
        } // HSTack

        HStack {
          Text(viewModel.product.description)
            .textFont(size: 12)
            .foregroundColor(.secondaryColor)
            .multilineTextAlignment(.leading)
          Spacer()
        } // HSTack

        HStack {
          Spacer()
          Text(viewModel.product.price.toCurrencyFormat())
            .textFont(size: 16)
            .foregroundColor(.primaryColor)
            .multilineTextAlignment(.trailing)
        } // HSTack
      } // VSTack
    } // HSTack
  }
}

struct ProductView_Previews: PreviewProvider {
  static var previews: some View {
    ProductRowView(
      ProductViewModel(
        product: Mocks.product
      )
    )
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
