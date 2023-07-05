//
//  FullscreenMoviePosterImage.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct FullscreenMoviePosterImage: View {
  let url: URL?

  var body: some View {
    ZStack {
      if let url = url {
        AsyncImage(url: url) { image in
          ZStack {
            GeometryReader { geometry in
              image
                .resizable()
                .blur(radius: 50)
                .overlay(Color.black.opacity(0.5))
                .frame(
                  width: geometry.frame(in: .global).width,
                  height: geometry.frame(in: .global).height
                )
            }
          }
          .edgesIgnoringSafeArea(.all)
        } placeholder: {
          ZStack {
            GeometryReader { geometry in
              Rectangle()
                .foregroundColor(Color.black.opacity(0.8))
                .frame(
                  width: geometry.frame(in: .global).width,
                  height: geometry.frame(in: .global).height
                )
            }
          }
          .edgesIgnoringSafeArea(.all)
        }
      } else {
        Rectangle()
          .foregroundColor(.gray)
          .imageStyle(loaded: false, size: .big)
      }
    }
  }
}
