//
//  PosterImage.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct PosterImage: View {
  let url: URL
  let size: ImageStyle.Size
  @State var isImageLoaded = false

  var body: some View {
    Group {
      AsyncImage(url: url) { image in
        image
          .resizable()
          .renderingMode(.original)
          .imageStyle(loaded: true, size: size)
          .onAppear {
            isImageLoaded = true
          }
          .animation(.easeInOut, value: isImageLoaded)
          .transition(.opacity)
      } placeholder: {
        Rectangle()
          .foregroundColor(.gray)
          .imageStyle(loaded: false, size: size)
      }
    }
  }
}

struct PosterImage_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .center, spacing: 8) {
      PosterImage(url: URL(string: "https://picsum.photos/640/640?r=2738")!, size: .small)
      PosterImage(url: URL(string: "https://picsum.photos/640/640?r=2738")!, size: .medium)
      PosterImage(url: URL(string: "https://picsum.photos/640/640?r=2738")!, size: .big)
    }
  }
}
