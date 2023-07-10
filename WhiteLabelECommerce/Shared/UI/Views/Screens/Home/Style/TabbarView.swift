//
//  TabbarView.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 10/07/23.
//

import SwiftUI

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
