//
//  HeaderView.swift
//  
//
//  Created by Marcos Vinicius Brito on 01/08/23.
//

import SwiftUI

struct HeaderView: View {
  var body: some View {
    HStack(alignment: .top) {
      Button {
        // TODO: Action
      } label: {
        Image(systemName: "square.grid.2x2.fill")
          .foregroundColor(.primaryColor)
          .frame(width: 40, height: 40)
          .background(Color.backgroundColor)
          .cornerRadius(20)
          .shadow(color: .gray, radius: 2)
      }
      Spacer(minLength: 16)

      Button {
        // TODO: Action
      } label: {
        Image(systemName: "square.and.arrow.up")
          .foregroundColor(.primaryColor)
          .frame(width: 40, height: 40)
          .background(Color.backgroundColor)
          .cornerRadius(20)
          .shadow(color: .gray, radius: 2)
      }
    }
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HeaderView()
        .previewLayout(.sizeThatFits)
      HeaderView()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        .previewLayout(.sizeThatFits)
      HeaderView()
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
  }
}
