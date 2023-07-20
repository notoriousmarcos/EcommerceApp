//
//  Products.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Combine
import SwiftUI

struct Products: View {
  private enum ViewMode {
    case list, grid

    func icon() -> String {
      switch self {
        case .list: return "rectangle.3.offgrid.fill"
        case .grid: return "rectangle.grid.1x2"
      }
    }
  }

  //    @StateObject private var selectedMenu = MoviesSelectedMenuStore(selectedMenu: MoviesMenu.allCases.first!)
  @EnvironmentObject var main: Main
  @State private var isSettingPresented = false
  @State private var viewMode = ViewMode.list

  private var settingButton: some View {
    Button(
      action: {
        self.isSettingPresented = true
      },
      label: {
        HStack {
          Image(systemName: "wrench").imageScale(.medium)
        }.frame(width: 30, height: 30)
      }
    )
  }

  private var swapModeButton: some View {
    Button(
      action: {
        self.viewMode = self.viewMode == .grid ? .list : .grid
      },
      label: {
        HStack {
          Image(systemName: self.viewMode.icon()).imageScale(.medium)
        }.frame(width: 30, height: 30)
      }
    )
  }

  @ViewBuilder private var productsAsList: some View {
    ProductList(viewModel: ProductListViewModel(fetchAllItems: main.getAllProductsUseCase.execute))
  }

  private var productsAsGrid: some View {
    // TODO: Create a grid view.
    Text("TODO: Create a grid view.")
  }

  var body: some View {
    NavigationView {
      Group {
        switch viewMode {
          case .list:
            productsAsList
          case .grid:
            productsAsGrid
        }
      }
      .navigationTitle("Products")
      .toolbar {
        ToolbarItemGroup {
          swapModeButton
          settingButton
        }
      }
    }
  }
}

#if DEBUG
struct MoviesHome_Previews: PreviewProvider {
  static var previews: some View {
    Products()
  }
}
#endif
