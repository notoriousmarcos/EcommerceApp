//
//  ProductDetail.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Backend
import Combine
import SwiftUI

struct ProductDetail: View {
  // MARK: View States
  @State var product: Product
  @State var isAddSheetPresented = false
  @State var isAddedToCart = false
  @State var selectedPoster: ImageData?

  // MARK: - View actions
  func addToCart(_ product: Product) {
    isAddedToCart = true
    // TODO: Perform add to cart action
  }

  func onAddButton() {
    isAddSheetPresented.toggle()
  }

  // MARK: - Body

  func topSection(_ product: Product) -> some View {
    Section {
      ProductCoverRow(product: product)
      if !product.description.isEmpty {
        ProductOverview(product: product)
      }
    }
  }

  var body: some View {
    ZStack(alignment: .bottom) {
      List {
        topSection(product)
      }
      .navigationTitle(product.title)
      .toolbar {
        ToolbarItemGroup {
          Button(action: onAddButton) {
            Image(systemName: "text.badge.plus").imageScale(.large)
          }
        }
      }
//      .navigationBarItems(
//        trailing: Button(action: onAddButton) {
//          Image(systemName: "text.badge.plus").imageScale(.large)
//        }
//      )
      .confirmationDialog(
        "Add \(product.title) from your cart",
        isPresented: $isAddSheetPresented,
        presenting: product
      ) { product in
        Button {
          // TODO: Implement add to cart.
        } label: {
          Text("Add \(product.title) to cart")
        }
        Button("Cancel", role: .cancel) { }
      }
//      .actionSheet(isPresented: $isAddSheetPresented, content: { addActionSheet(product) })
      .disabled(selectedPoster != nil)
      .blur(radius: selectedPoster != nil ? 30 : 0)
      .scaleEffect(selectedPoster != nil ? 0.8 : 1)
    }
  }
}

// MARK: - Preview
#if DEBUG
// struct ProductDetail_Previews: PreviewProvider {
//  static var previews: some View {
//    NavigationView {
//      ProductDetail(product: Mocks.product)
//    }
//  }
// }
#endif
