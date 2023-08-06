//
//  CartView.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import AppState
import ShopCore
import Mock
import NotoriousComponentsKit
import SwiftUI

public struct CartView<ViewModel: ObservableObject & CartViewModel>: View {
  @ObservedObject var viewModel: ViewModel

  public init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    ZStack {
      List {
        ForEach(viewModel.items, id: \.product.id) { item in
          CartListRow(
            item: $viewModel.items[getIndex(item)],
            minusAction: { item in
              viewModel.decreaseOrRemoveQuantityFor(item)
            },
            plusAction: { item in
              viewModel.increaseQuantityFor(item)
            }
          )
        }
        .onDelete { index in
          viewModel.removeProductFor(index)
        }
      }
      .listStyle(.plain)
      .navigationTitle("My Cart")
    }
    .onAppear {
      viewModel.handleCartUpdate()
    }
  }

  func getIndex(_ item: CartItemData) -> Int {
    viewModel.items.firstIndex { $0.product.id == item.product.id } ?? 0
  }
}

struct CartView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CartView(viewModel: MockViewModel())
      CartView(viewModel: MockViewModel())
      .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      CartView(viewModel: MockViewModel())
      .preferredColorScheme(.dark)
    }
  }
}

private class MockViewModel: CartViewModel {
  var items: [CartItemData] = Mocks.products.map { CartItemData(product: $0, quantity: 1) }

  func handleCartUpdate() { }

  func decreaseOrRemoveQuantityFor(_ item: CartItemData) {
    guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
    if items[index].quantity > 1 {
      items[index].quantity -= 1
    } else {
      items.remove(at: index)
    }
  }

  func increaseQuantityFor(_ item: CartItemData) {
    guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
    items[index].quantity += 1
  }

  func removeProductFor(_ index: IndexSet) {
    
  }
}
