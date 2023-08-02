//
//  SwiftUIView.swift
//  
//
//  Created by Marcos Vinicius Brito on 02/08/23.
//

import SwiftUI

struct SectionView: View {
  let section: Section

  var body: some View {
    VStack {
      HStack {
        Text(section.title)
        Spacer(minLength: 8)

        Button {
          // TODO: - Action
          section.action()
        } label: {
          Text(section.actionTitle)
            .foregroundColor(.primaryColor)
        }
      } //: HStack
    }
  }
}

struct SectionView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SectionView(section: Section(title: "Title", actionTitle: "Button Title", action: {}))
        .previewLayout(.sizeThatFits)
      SectionView(section: Section(title: "Title", actionTitle: "Button Title", action: {}))
        .previewLayout(.sizeThatFits)
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      SectionView(section: Section(title: "Title", actionTitle: "Button Title", action: {}))
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
  }
}
