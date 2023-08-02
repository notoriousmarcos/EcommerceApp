//
//  SectionAndProductsGridView.swift
//  
//
//  Created by Marcos Vinicius Brito on 02/08/23.
//

import SwiftUI

struct SectionAndContentView<Content: View>: View {

  let section: Section
  let content: () -> Content

  init(section: Section, @ViewBuilder content: @escaping () -> Content) {
    self.section = section
    self.content = content
  }

  var body: some View {
    VStack {
      SectionView(section: section)

      content()
    }
  }
}

struct SectionAndProductsGridView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SectionAndContentView(
        section: Section(title: "Title", actionTitle: "Button Title", action: {}),
        content: { Text("Content") }
      )
      SectionAndContentView(
        section: Section(title: "Title", actionTitle: "Button Title", action: {}),
        content: { Text("Content") }
      )
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      SectionAndContentView(
        section: Section(title: "Title", actionTitle: "Button Title", action: {}),
        content: { Text("Content") }
      )
        .preferredColorScheme(.dark)
    }
  }
}
