//
//  SearchView.swift
//  
//
//  Created by Marcos Vinicius Brito on 01/08/23.
//

import SwiftUI

struct SearchView: View {
  // MARK: - Properties
  let searchText: Binding<String>

  var body: some View {
    HStack {
      HStack(alignment: .center, spacing: 8) {
        Image(systemName: "magnifyingglass")
        TextField("Search", text: searchText)
      }
      .padding(16)
    }
    .background(Color.backgroundColor)
    .cornerRadius(8)
    .shadow(color: .gray, radius: 2)
  }
}

struct SearchView_Previews: PreviewProvider {
  static var searchText: Binding<String> = .constant("")
  static var previews: some View {
    Group {
      SearchView(searchText: searchText)
        .previewLayout(.sizeThatFits)
      SearchView(searchText: searchText)
        .previewLayout(.sizeThatFits)
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      SearchView(searchText: searchText)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
  }
}
