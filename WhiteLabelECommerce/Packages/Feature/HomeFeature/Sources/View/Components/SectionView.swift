//
//  SwiftUIView.swift
//  
//
//  Created by Marcos Vinicius Brito on 02/08/23.
//

import SwiftUI

struct SectionView: View {
  let title: String
  let actionTitle: String
  let action: () -> Void

  var body: some View {
    VStack {
      HStack {
        Text(title)
        Spacer(minLength: 8)

        Button {
          // TODO: - Action
          action()
        } label: {
          Text(actionTitle)
            .foregroundColor(.primaryColor)
        }
      } //: HStack
    }
  }
}

struct SectionView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SectionView(title: "Title", actionTitle: "Button Title", action: {})
        .previewLayout(.sizeThatFits)
      SectionView(title: "Title", actionTitle: "Button Title", action: {})
        .previewLayout(.sizeThatFits)
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      SectionView(title: "Title", actionTitle: "Button Title", action: {})
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
  }
}
