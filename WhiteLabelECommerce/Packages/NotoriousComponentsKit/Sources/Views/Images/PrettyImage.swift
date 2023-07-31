//
//  PosterImage.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

public struct PrettyImage: View {
  let url: URL
  @State var isImageLoaded = false

  public init(url: URL) {
    self.url = url
  }

  public var body: some View {
    Group {
      AsyncImage(url: url) { image in
        image
          .resizable()
          .renderingMode(.original)
          .imageStyle(loaded: true)
          .onAppear {
            isImageLoaded = true
          }
          .animation(.easeInOut, value: isImageLoaded)
          .transition(.opacity)
      } placeholder: {
        Rectangle()
          .foregroundColor(.gray)
          .imageStyle(loaded: false)
      }
    }
  }
}

struct PrettyImage_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .center, spacing: 8) {
      PrettyImage(url: URL(string: "https://picsum.photos/640/640?r=2738")!)
    }
  }
}
