//
//  ProductItemCellView.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 30/12/22.
//

import SwiftUI

struct ProductItemCellView: View {
    var product: Product

    init(product: Product) {
        self.product = product
    }
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 16) {
//                if let urlString = product.imageURL,
//                   let url = URL(string: urlString),
//                   let image = UIImage(data: try! Data(contentsOf: url))
//                {
//                    Image(uiImage: image)
//                }
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.title)
                    Text(product.description)
                }
                Text("$\(product.price)")
            }
        }
        .onAppear(perform: { })
    }
}

struct ProductItemCellView_Previews: PreviewProvider {
    static var product: Product = Mocks.product

    static var previews: some View {
        ProductItemCellView(product: product)
            .environment(\.sizeCategory, .extraSmall)

        ProductItemCellView(product: product)

        ProductItemCellView(product: product)
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
