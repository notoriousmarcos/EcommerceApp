//
//  MovieOverview.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct ProductOverview: View {
  @State var product: Product
  @State var isOverviewExpanded = false

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Description:")
        .titleStyle()
        .lineLimit(1)

      Text(product.description)
        .font(.subheadline)
        .foregroundColor(.secondary)
        .lineLimit(self.isOverviewExpanded ? nil : 4)
        .onTapGesture {
          withAnimation {
            self.isOverviewExpanded.toggle()
          }
        }

      Button(
        action: {
          withAnimation {
            self.isOverviewExpanded.toggle()
          }
        },
        label: {
          Text(self.isOverviewExpanded ? "Less" : "Read more")
            .lineLimit(1)
            .foregroundColor(.steamBlue)
        })
    }
  }
}

#if DEBUG
struct ProductOverview_Previews: PreviewProvider {
  static var previews: some View {
    ProductOverview(product: Mocks.product)
  }
}
#endif
