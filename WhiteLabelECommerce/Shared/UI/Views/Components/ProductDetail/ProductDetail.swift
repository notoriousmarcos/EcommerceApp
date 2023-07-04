//
//  ProductDetail.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Combine
import SwiftUI

struct ProductDetail: View {

  // MARK: View States
  @State var productId: Int
  @State var isAddSheetPresented = false
  @State var isAddedToCart = false
  @State var selectedPoster: ImageData?
  @State private var product: Product?

  // MARK: - View actions
  func addToCart(_ product: Product) {
    isAddedToCart = true
    // TODO: Perform add to cart action
  }

  func onAddButton() {
    isAddSheetPresented.toggle()
  }

  // MARK: - Computed views
  func addActionSheet(_ product: Product) -> ActionSheet {
    var buttons: [Alert.Button] = []
    let addToCart: Alert.Button = .default(Text("Sort by added date")) {
      self.addToCart(product)
    }
    let cancelButton = Alert.Button.cancel { }
    buttons.append(addToCart)
    buttons.append(cancelButton)
    let sheet = ActionSheet(
      title: Text("Add \(product.title) from your cart"),
      message: nil,
      buttons: buttons
    )
    return sheet
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
      if let product = product {
        List {
          topSection(product)
        }
        .navigationBarTitle(Text(product.title), displayMode: .large)
        .navigationBarItems(
          trailing: Button(action: onAddButton) {
            Image(systemName: "text.badge.plus").imageScale(.large)
          }
        )
        .actionSheet(isPresented: $isAddSheetPresented, content: { addActionSheet(product) })
        .disabled(selectedPoster != nil)
        .blur(radius: selectedPoster != nil ? 30 : 0)
        .scaleEffect(selectedPoster != nil ? 0.8 : 1)
      }
      else {
        Rectangle()
          .foregroundColor(.gray)
          .imageStyle(loaded: false, size: .big)

      }
    }
  }
}

// MARK: - Preview
#if DEBUG
struct ProductDetail_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ProductDetail(productId: Mocks.product.id)
    }.navigationViewStyle(StackNavigationViewStyle())
  }
}
#endif
