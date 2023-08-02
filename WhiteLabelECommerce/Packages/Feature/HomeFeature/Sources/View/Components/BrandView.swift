//
//  BrandView.swift
//  
//
//  Created by Marcos Vinicius Brito on 01/08/23.
//

import SwiftUI

struct BrandView: View {
  var body: some View {
    VStack {
      SectionView(
        section: Section(
          title: "Choose your brand",
          actionTitle: "See all",
          action: {
            // TODO: - Action
          }
        )
      )

      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(0..<60) { index in
            VStack {
              Image(systemName: "square.and.arrow.up")
                .frame(width: 40, height: 40)
              Text("Brand")
            } //: VStack
            .frame(width: 80, height: 100)
            .background(Color.backgroundColor)
            .cornerRadius(8)
            .shadow(color: .gray, radius: 2)
            .padding(4)
          } //: ForEach
        } //: HStack
      } //: ScrollView
      .frame(height: 100)
    } //: VStack
  }
}

struct BrandView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      BrandView()
        .previewLayout(.sizeThatFits)
      BrandView()
        .previewLayout(.sizeThatFits)
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      BrandView()
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
  }
}
