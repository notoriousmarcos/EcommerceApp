//
//  HomeView.swift
//  
//
//  Created by Marcos Vinicius Brito on 01/08/23.
//

import SwiftUI
import NotoriousComponentsKit
import ProductsFeature

struct HomeView: View {
  // MARK: - Properties
  @State var searchText = ""

  // MARK: - Body
  var body: some View {
    ZStack {
      // MARK: - Background
      Color.backgroundColor

      ScrollView(.vertical, showsIndicators: true) {
        VStack(spacing: 24) {
          HeaderView() //: HStack

          //        BrandView()
          //          .padding(.top, 16)

          HomeToolBarView(searchText: $searchText)

          SectionAndContentView {
            ProductsGridView()
          }

        } //: VStack
        .padding(.horizontal, 24)
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HomeView()
      HomeView()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      HomeView()
        .preferredColorScheme(.dark)
    }
  }
}
