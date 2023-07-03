//
//  FullscreenMoviePosterImage.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Backend
import SwiftUI

struct FullscreenMoviePosterImage: View {
    @ObservedObject var imageLoader: ImageLoader

    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                ZStack {
                    GeometryReader { geometry in
                        Image(uiImage: self.imageLoader.image!)
                            .resizable()
                            .blur(radius: 50)
                            .overlay(Color.black.opacity(0.5))
                            .frame(width: geometry.frame(in: .global).width,
                                   height: geometry.frame(in: .global).height)
                    }
                }.edgesIgnoringSafeArea(.all)
            } else {
                ZStack {
                    GeometryReader { geometry in
                        Rectangle()
                            .foregroundColor(Color.black.opacity(0.8))
                            .frame(width: geometry.frame(in: .global).width,
                                   height: geometry.frame(in: .global).height)
                    }
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}
