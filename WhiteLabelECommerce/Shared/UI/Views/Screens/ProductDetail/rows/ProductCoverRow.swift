//
//  ProductCoverRow.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI
import Backend

struct ProductCoverRow: View {
    let product: Product

  var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                  PosterImage(url: URL(string: product.imageURL ?? ""), size: .medium)
                        .padding(.leading, 16)

                    VStack(alignment: .leading, spacing: 16) {
                      Text("\(product.price)")
                      Text(product.category)
                    }
                }
            }
        }
        .listRowInsets(EdgeInsets())
    }
}

#if DEBUG
//struct MovieCoverRow_Previews: PreviewProvider {
//    static var previews: some View {
//      ProductCoverRow(product: Mocks.product)
//    }
//}
#endif
