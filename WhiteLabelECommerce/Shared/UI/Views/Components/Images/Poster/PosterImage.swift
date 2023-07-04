//
//  PosterImage.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct PosterImage: View {
  let url: URL?
  let size: ImageStyle.Size
  @State var isImageLoaded = false

  var body: some View {
    Group {
      if let url = url {
        AsyncImage(url: url) { image in
          image
            .resizable()
            .renderingMode(.original)
            .imageStyle(loaded: true, size: size)
            .onAppear {
              isImageLoaded = true
            }
            .animation(.easeInOut)
            .transition(.opacity)
        } placeholder: {
          Rectangle()
            .foregroundColor(.gray)
            .imageStyle(loaded: false, size: size)
        }
      } else {
        Rectangle()
          .foregroundColor(.gray)
          .imageStyle(loaded: false, size: size)
      }
    }
  }
}
