//
//  CartView.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import Backend
import Mock
import NotoriousComponentsKit
import SwiftUI

public struct CartView: View {
  @ObservedObject var viewModel: CartViewModel

  public init(viewModel: CartViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    ZStack {
      List(viewModel.items, id: \.product.id) { item in
        CartListRow(
          item: $viewModel.items[getIndex(item)],
          minusAction: { _ in
            viewModel.decreaseOrRemoveQuantityFor(item)
          },
          plusAction: { _ in
            viewModel.increaseQuantityFor(item)
          }
        )
      }
      .listStyle(.plain)
      .navigationTitle("My Cart")
    }
    .onAppear {
      viewModel.reload()
    }
  }

  func getIndex(_ item: CartItemData) -> Int {
    viewModel.items.firstIndex { $0.product.id == item.product.id } ?? 0
  }
}

struct CartView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
//      CartView(viewModel: CartViewModel())
//      CartView(viewModel: CartViewModel())
//        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
//      CartView(viewModel: CartViewModel())
//        .preferredColorScheme(.dark)
    }
  }
}

extension Mocks {
  static var cartViewData: CartViewData {
    CartViewData(
      userId: cart.userId,
      date: cart.date,
      products: products.map { CartItemData(product: $0, quantity: 1) }
    )
  }
}
