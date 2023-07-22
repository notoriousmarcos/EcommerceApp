//
//  BigMoviePosterImage.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct BigMoviePosterImage: View {
  let url: URL?
  let size: ImageStyle.Size
  @State var isImageLoaded = false

  var scale: Double {
    isImageLoaded ? 1 : 0.6
  }

  var body: some View {
    ZStack(alignment: .center) {
      if let url = url {
        AsyncImage(url: url) { image in
          image
            .resizable()
            .renderingMode(.original)
            .imageStyle(loaded: true, size: .big)
            .scaleEffect(scale)
            .animation(.spring(), value: scale)
            .onAppear {
              self.isImageLoaded = true
            }
        } placeholder: {
          Rectangle()
            .foregroundColor(.gray)
            .imageStyle(loaded: false, size: .big)
        }
      } else {
        Rectangle()
          .foregroundColor(.gray)
          .imageStyle(loaded: false, size: .big)
      }
    }
  }
}
