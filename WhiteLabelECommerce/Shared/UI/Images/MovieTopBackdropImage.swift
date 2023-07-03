//
//  MovieBackdropImage.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Backend
import SwiftUI

struct MovieTopBackdropImage: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var isImageLoaded = false

    var fill = false
    var height: CGFloat = 250

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .blur(radius: 50, opaque: true)
                .overlay(Color.black.opacity(0.3))
                .frame(height: fill ? 50 : height)
                .onAppear {
                    isImageLoaded = true
                }
                .animation(.easeInOut)
                .transition(.opacity)
        } else {
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.3)
                .frame(height: fill ? 50 : height)
        }
    }
}
