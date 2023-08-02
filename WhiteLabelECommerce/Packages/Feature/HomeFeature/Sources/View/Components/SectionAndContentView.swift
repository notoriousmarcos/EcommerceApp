//
//  SectionAndProductsGridView.swift
//  
//
//  Created by Marcos Vinicius Brito on 02/08/23.
//

import SwiftUI

struct SectionAndContentView<Content: View>: View {

  let content: () -> Content

  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }

  var body: some View {
    VStack {
      SectionView(
        title: "Top Headphone",
        actionTitle: "See all"
      ) {
        // TODO: - Action
      }

      content()
    }
  }
}

struct SectionAndProductsGridView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SectionAndContentView(content: { Text("Content") })
      SectionAndContentView(content: { Text("Content") })
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      SectionAndContentView(content: { Text("Content") })
        .preferredColorScheme(.dark)
    }
  }
}
