//
//  MoviePostersCarouselView.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

protocol ImageData {
  var url: URL? { get }
}

struct ImagesCarouselView<ImageInfo: ImageData>: View {
  let images: [ImageInfo]
  @Binding var selectedPoster: ImageInfo?
  @State var innerSelectedPoster: ImageInfo?

  func computeCarouselPosterScale(width: CGFloat, itemX: CGFloat) -> CGFloat {
    let trueX = itemX - (width / 2 - 200 / 2) - 100
    if trueX < -5 {
      return 1 - (abs(trueX) / width)
    }
    if trueX > 5 {
      return 1 - (trueX / width)
    }
    return 1
  }

  private func scrollView(geoProxy: GeometryProxy) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 16) {
        ForEach(self.images, id: \.url) { image in
          GeometryReader { proxy in
            BigMoviePosterImage(url: image.url, size: .medium)
              .scaleEffect(
                self.selectedPoster == nil ?
                  .zero : self.computeCarouselPosterScale(
                    width: geoProxy.frame(in: .global).width,
                    itemX: proxy.frame(in: .global).midX
                  ),
                anchor: .center
              )
              .onTapGesture {
                withAnimation {
                  self.innerSelectedPoster = image
                }
              }
          }.frame(width: 250, height: 375)
        }
      }
    }
    .disabled(self.innerSelectedPoster != nil)
    .scaleEffect(self.innerSelectedPoster != nil ? 0 : 1)
    .position(
      x: geoProxy.frame(in: .global).midX,
      y: geoProxy.frame(in: .local).midY
    )
  }

  private func closeButton(geoProxy: GeometryProxy) -> some View {
    Button(action: {
      self.selectedPoster = nil
    }) {
      Circle()
        .strokeBorder(Color.red, lineWidth: 1)
        .background(Image(systemName: "xmark").foregroundColor(.red))
        .frame(width: 50, height: 50)
    }
    .scaleEffect(self.innerSelectedPoster != nil ? 0 : 1)
    .position(
      x: geoProxy.frame(in: .local).midX,
      y: geoProxy.frame(in: .local).maxY - 40
    )
  }

  private func selectedPoster(geoProxy: GeometryProxy) -> some View {
    BigMoviePosterImage(
      url: innerSelectedPoster?.url ?? URL(string: ""), size: .medium
    )
    .position(
      x: geoProxy.frame(in: .local).midX,
      y: geoProxy.frame(in: .global).midY - 120
    )
    .scaleEffect(1.3)
    .onTapGesture {
      withAnimation {
        self.innerSelectedPoster = nil
      }
    }
  }

  var body: some View {
    GeometryReader { geoProxy in
      ZStack(alignment: .center) {
        self.scrollView(geoProxy: geoProxy)
        self.closeButton(geoProxy: geoProxy)

        if self.innerSelectedPoster != nil {
          self.selectedPoster(geoProxy: geoProxy)
        }
      }
    }
  }
}

#if DEBUG
//struct MoviePostersCarouselView_Previews: PreviewProvider {
//  static var previews: some View {
//    ImagesCarouselView(posters: [ImageData(aspect_ratio: 0.666_666_666_666_667,
//                                           file_path: "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
//                                           height: 720,
//                                           width: 1280),
//                                 ImageData(aspect_ratio: 0.666_666_666_666_667,
//                                           file_path: "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
//                                           height: 720,
//                                           width: 1280),
//                                 ImageData(aspect_ratio: 0.666_666_666_666_667,
//                                           file_path: "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
//                                           height: 720,
//                                           width: 1280),
//                                 ImageData(aspect_ratio: 0.666_666_666_666_667,
//                                           file_path: "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
//                                           height: 720,
//                                           width: 1280)],
//                       selectedPoster: .constant(nil))
//  }
//}
#endif
