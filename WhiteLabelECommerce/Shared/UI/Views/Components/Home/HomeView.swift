//
//  Tabbar.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

// MARK: - Shared View

struct HomeView: View {

#if targetEnvironment(macCatalyst)
  var body: some View {
    SplitView().accentColor(.steamGold)
  }
#else
  var body: some View {
    TabbarView().accentColor(.steamGold)
  }
#endif

  private func setupApperance() {
    UINavigationBar.appearance().largeTitleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor(named: "steam_gold")!,
      NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 40)!
    ]

    UINavigationBar.appearance().titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor(named: "steam_gold")!,
      NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 18)!
    ]

    UIBarButtonItem.appearance().setTitleTextAttributes(
      [
        NSAttributedString.Key.foregroundColor: UIColor(named: "steam_gold")!,
        NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 16)!
      ],
      for: .normal
    )

    UIWindow.appearance().tintColor = UIColor(named: "steam_gold")
  }
}

// MARK: - iOS implementation
struct TabbarView: View {
  @State var selectedTab = Tab.products

  enum Tab: Int {
    case products, cart
  }

  func tabbarItem(text: String, image: String) -> some View {
    VStack {
      Image(systemName: image)
        .imageScale(.large)
      Text(text)
    }
  }

  var body: some View {
    TabView(selection: $selectedTab) {
      Products().tabItem {
        self.tabbarItem(text: "Products", image: "Products")
      }.tag(Tab.products)
    }
  }
}

// MARK: - MacOS implementation
struct SplitView: View {
  @State var selectedMenu: OutlineMenu = .products

  @ViewBuilder
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

//      switch selectedMenu {
//        case .products:
//          ProductList(viewModel: <#T##ListItemsViewModelProtocol#>)
//      }
//      selectedMenu.contentView
    }
  }
}

#if DEBUG
#endif
