//
//  SplitView.swift
//  WhiteLabelECommerce (macOS)
//
//  Created by Marcos Vinicius Brito on 10/07/23.
//

import SwiftUI

struct SplitView: View {
  @EnvironmentObject var main: Main
  @State var selectedMenu: OutlineMenu = .products

  var body: some View {
    HStack(spacing: 0) {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading) {
          ForEach(OutlineMenu.allCases) { menu in
            ZStack(alignment: .leading) {
              OutlineRow(item: menu, selectedMenu: self.$selectedMenu)
                .frame(height: 50)
              if menu == self.selectedMenu {
                Rectangle()
                  .foregroundColor(Color.secondary.opacity(0.1))
                  .frame(height: 50)
              }
            }
          }
        }
        .padding(.top, 32)
        .frame(width: 300)
      }
      .background(Color.primary.opacity(0.1))

      switch selectedMenu {
        case .products:
          ProductList(viewModel: ProductListViewModel(fetchAllItems: main.getAllProductsUseCase.execute))
      }
      //      selectedMenu.contentView
    }
  }
}
