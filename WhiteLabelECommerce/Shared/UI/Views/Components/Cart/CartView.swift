//
//  Cart.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct CartView: View {
  // MARK: - Vars
  @State private var cart: Cart
  @State private var selectedMoviesSort = ProductSort.byAddedDate
  @State private var isSortActionSheetPresented = false

  // MARK: - Dynamic views
  private var sortActionSheet: ActionSheet {
    ActionSheet.sortActionSheet { sort in
      if let sort = sort {
        self.selectedMoviesSort = sort
      }
    }
  }

  var body: some View {
    NavigationView {
      List {
        Section(header: Text("Cart")) {
          ForEach(cart.products, id: \.productId) { item in
            NavigationLink(destination: ProductDetail(productId: item.productId)) {
              ProductRow(productId: productId, displayListImage: false)
            }
          }
          .onDelete { index in
            // TODO: Remove product from cart.
          }
        }
      }
      .listStyle(GroupedListStyle())
      .actionSheet(isPresented: $isSortActionSheetPresented, content: { sortActionSheet })
      .navigationBarTitle(Text("My Cart"))
      .navigationBarItems(trailing: Button(action: {
        self.isSortActionSheetPresented.toggle()
      }, label: {
        Image(systemName: "line.horizontal.3.decrease.circle")
          .resizable()
          .frame(width: 25, height: 25)
      }))
    }
  }
}

#if DEBUG
struct CartView_Previews: PreviewProvider {
  static var previews: some View {

  }
}
#endif
