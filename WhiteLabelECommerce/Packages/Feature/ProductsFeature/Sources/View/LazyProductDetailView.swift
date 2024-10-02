//
//  SwiftUIView.swift
//  
//
//  Created by Marcos Vinicius Brito on 16/08/23.
//

import Mock
import ShopCore
import SwiftUI

struct LazyProductDetailView: View {
  private let product: Binding<Product?>

  init(product: Binding<Product?>) {
    self.product = product
  }

  var body: some View {
    if let product = product.wrappedValue {
      ProductDetailView(ProductDetailViewModel(product: product))
    }
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    LazyProductDetailView(product: .constant(Mocks.product))
  }
}
