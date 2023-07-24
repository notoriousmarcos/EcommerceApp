//
//  ProductDetailView.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import SwiftUI
import UI

struct ProductDetailView: View {
  // MARK: - Properties
  @ObservedObject private var viewModel: ProductDetailViewModel

  init(_ viewModel: ProductDetailViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body
  var body: some View {
    ZStack {
      Color.backgroundColor

      ScrollView {
        LazyVStack(
          alignment: .center,
          spacing: 16
        ) {
          Section {
            VStack {
              HStack(alignment: .top, spacing: 16) {
                HStack {
                  Text(viewModel.product.title)
                    .textFont(size: 32)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                  Spacer()
                }
                HStack {
                  Spacer()
                  Text(viewModel.product.price.toCurrencyFormat())
                    .textFont(size: 20)
                    .font(.system(.title3, design: .rounded))
                    .multilineTextAlignment(.trailing)
                    .lineLimit(1)
                }
              }
              .padding(.bottom, 4)
              HStack {
                Text("Details")
                  .textFont(size: 20)
                  .foregroundColor(.primaryColor)
                  .multilineTextAlignment(.leading)
                  .lineLimit(1)
                Spacer()
              }
              .padding(.bottom, 2)
              HStack {
                Text(viewModel.product.description)
                  .textFont(size: 16)
                  .shadow(color: .secondaryColor, radius: 4)
                  .font(.system(.body, design: .rounded))
                  .multilineTextAlignment(.leading)
                Spacer()
              }
            }
            .padding(8)
          } header: {
            if let imageURL = viewModel.product.imagesURL.first {
              PosterImage(url: imageURL, size: .big)
            }
          } footer: {
            EmptyView()
          }
        }
        .frame(maxWidth: .infinity)
      }
    }
  }
}

struct ProductDetailView_Previews: PreviewProvider {
  static var previews: some View {
    ProductDetailView(
      ProductDetailViewModel(
        product: ProductViewItem(
          id: 1,
          title: "Title",
          price: 12_222.99,
          category: .init(
            id: 1,
            name: "Category",
            imageURL: URL(string: "https://picsum.photos/640/640?r=2738")
          ),
          description: """
                     Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                     Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
                     when an unknown printer took a galley of type and scrambled it to make a type specimen book.
                     """,
          imagesURL: [URL(string: "https://picsum.photos/640/640?r=2738")!]
        )
      )
    )
  }
}
