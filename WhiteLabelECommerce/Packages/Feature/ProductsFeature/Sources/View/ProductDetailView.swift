//
//  ProductDetailView.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Mock
import NotoriousComponentsKit
import SwiftUI

struct ProductDetailView: View {
  // MARK: - Properties
  @ObservedObject private var viewModel: ProductDetailViewModel

  init(_ viewModel: ProductDetailViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body
  var body: some View {
    ZStack {
      ScrollView {
        LazyVStack(
          alignment: .center,
          spacing: 16
        ) {
          VStack(alignment: .leading) {
            GeometryReader { geometry in
              CarouselView(numberOfImages: viewModel.product.imagesURL.count) {
                ForEach(viewModel.product.imagesURL.compactMap { URL(string: $0) }, id: \.absoluteString) { url in
                  PrettyImage(url: url)
                    .padding(.horizontal, 16)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
              }
            }
            .frame(height: 350, alignment: .center)
            .padding(.vertical, 15)

            HStack(alignment: .top, spacing: 16) {
              Text(viewModel.product.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primaryColor)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
              Spacer()
              Text(viewModel.product.price.toCurrencyFormat())
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.secondaryColor)
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
            }
            .padding(.bottom, 4)

            Text("Details")
              .font(.title3)
              .fontWeight(.bold)
              .foregroundColor(.secondaryColor)
              .multilineTextAlignment(.leading)
              .lineLimit(1)
              .padding(.bottom, 2)

            Text(viewModel.product.description)
              .font(.body)
              .foregroundColor(.secondaryColor)
              .multilineTextAlignment(.leading)
          }
          .padding(16)
        }
        .frame(maxWidth: .infinity)
      }
    }
#if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
#endif
    .frame(minWidth: 375)
  }
}

struct ProductDetailView_Previews: PreviewProvider {
  static var previews: some View {
    ProductDetailView(
      ProductDetailViewModel(
        product: Mocks.product
      )
    )
  }
}
