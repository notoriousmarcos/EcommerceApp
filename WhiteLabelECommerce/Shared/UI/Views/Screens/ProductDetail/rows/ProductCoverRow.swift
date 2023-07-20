//
//  ProductCoverRow.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Backend
import SwiftUI

struct ProductCoverRow: View {
    let product: Product

  var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                  PosterImage(url: URL(string: product.imagesURL.first ?? ""), size: .medium)
                        .padding(.leading, 16)

                    VStack(alignment: .leading, spacing: 16) {
                      Text("\(product.price)")
                      Text(product.category.name)
                    }
                }
            }
        }
        .listRowInsets(EdgeInsets())
    }
}

#if DEBUG
// struct MovieCoverRow_Previews: PreviewProvider {
//    static var previews: some View {
//      ProductCoverRow(product: Mocks.product)
//    }
// }
#endif
