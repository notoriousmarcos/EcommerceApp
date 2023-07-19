//
//  ProductRow.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI
import Backend

struct ProductRow: View {
  // MARK: - Init
  @State var product: Product

  var body: some View {
    HStack {
      ZStack(alignment: .topLeading) {
        PosterImage(url: URL(string: product.imageURL ?? ""), size: .medium)
      }
      .fixedSize()
      .animation(.spring(), value: 1)

      VStack(alignment: .leading, spacing: 8) {
        Text(product.title)
          .titleStyle()
          .foregroundColor(.steamGold)
          .lineLimit(2)

        HStack {
          Text("\(product.price)")
            .font(.subheadline)
            .foregroundColor(.primary)
            .lineLimit(1)
        }

        Text(product.description)
          .foregroundColor(.secondary)
          .lineLimit(3)
          .truncationMode(.tail)
      }
      .padding(.leading, 8)
    }
    .padding(.top, 8)
    .padding(.bottom, 8)
  }
}

#if DEBUG
//struct MovieRow_Previews: PreviewProvider {
//  static var previews: some View {
//    List {
//      ProductRow(product: Mocks.product)
//    }
//  }
//}
#endif
