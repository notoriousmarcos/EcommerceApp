//
//  PeopleImage.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Backend
import SwiftUI

struct PeopleImage: View {
    @ObservedObject var imageLoader: ImageLoader

    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
                    .cornerRadius(10)
                    .frame(width: 60, height: 90)
            } else {
                Rectangle()
                    .cornerRadius(10)
                    .frame(width: 60, height: 90)
                    .foregroundColor(.gray)
                    .opacity(0.1)
            }
        }
    }
}

struct BigPeopleImage: View {
    @ObservedObject var imageLoader: ImageLoader

    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
                    .cornerRadius(10)
                    .frame(width: 100, height: 150)
            } else {
                Rectangle()
                    .cornerRadius(10)
                    .frame(width: 100, height: 150)
                    .foregroundColor(.gray)
                    .opacity(0.1)
            }
        }
    }
}
