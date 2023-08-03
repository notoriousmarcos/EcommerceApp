//
//  SwiftUIView.swift
//  
//
//  Created by Marcos Vinicius Brito on 02/08/23.
//

import NotoriousComponentsKit
import SwiftUI

struct ProductGridItemView: View {
  // MARK: - Properties
  @ObservedObject private var viewModel: ProductViewModel

  init(_ viewModel: ProductViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body
  var body: some View {
    VStack {
      VStack(spacing: 4) {
        if let imagesURL = viewModel.product.imagesURL.first {
          PrettyImage(url: imagesURL)
            .frame(height: 160)
        } else {
          EmptyView()
            .frame(height: 160)
        }

        HStack(alignment: .top) {
          VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.product.title)
              .fontWeight(.medium)
              .font(.subheadline)
              .foregroundColor(.primary)
              .multilineTextAlignment(.leading)
              .lineLimit(2)
              .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(viewModel.product.price.toCurrencyFormat())")
              .font(.title3)
              .fontWeight(.semibold)
              .foregroundColor(.primary)
              .multilineTextAlignment(.leading)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          .frame(maxWidth: .infinity, alignment: .leading)

          VStack(alignment: .trailing) {
            Spacer()
            ZStack {
              Color.secondaryColor

              Button {
                // TODO: - Action
                viewModel.addToCart()
              } label: {
                Image(systemName: "cart.badge.plus")
                  .foregroundColor(.white)
              }
            }
            .frame(width: 40, height: 40)
            .cornerRadius(20)
          }
        } //: HStack
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 4)

        Spacer(minLength: 4)
      } //: VStack
      .background(Color.backgroundColor)
      .cornerRadius(12)
      .padding(.vertical, 4)
      .shadow(color: .gray, radius: 1)
    } //: VStack
    .aspectRatio(0.9, contentMode: .fit)
    .frame(height: 240)

  }
}

struct ProductGridItemView_Previews: PreviewProvider {
  static var previews: some View {
    ProductGridItemView(
      ProductViewModel(
        product: ProductViewItem(
          id: 1,
          title: "Title",
          price: 12_222.99,
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
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
