//
//  HomeToolBarView.swift
//  
//
//  Created by Marcos Vinicius Brito on 01/08/23.
//

import SwiftUI

struct HomeToolBarView: View {
  // MARK: - Properties
  let searchText: Binding<String>

  var body: some View {
    HStack {
      SearchView(searchText: searchText)
      Button {
        // TODO: Action
      } label: {
        Image(systemName: "slider.horizontal.3")
          .foregroundColor(.primaryColor)
          .dynamicTypeSize(.accessibility1)
          .frame(width: 40, height: 40)
      }
    }
  }
}

struct HomeToolBarView_Previews: PreviewProvider {
  static var searchText: Binding<String> = .constant("")
  static var previews: some View {
    Group {
      HomeToolBarView(searchText: searchText)
        .previewLayout(.sizeThatFits)
      HomeToolBarView(searchText: searchText)
        .previewLayout(.sizeThatFits)
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      HomeToolBarView(searchText: searchText)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
  }
}
