//
//  MoviePostersRow.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Backend
import SwiftUI

struct MoviePostersRow: View {
    let posters: [ImageData]
    @Binding var selectedPoster: ImageData?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Other posters")
                .titleStyle()
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 32) {
                    ForEach(self.posters) { poster in
                        MoviePosterImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: poster.file_path,
                                                                                        size: .medium),
                                         posterSize: .medium)
                            .onTapGesture {
                                withAnimation {
                                    self.selectedPoster = poster
                                }
                            }
                        .padding(.vertical)
                    }
                }
                .padding(.leading)
            }
        }
        .listRowInsets(EdgeInsets())
        .padding(.vertical)
    }
}

#if DEBUG
struct MoviePostersRow_Previews: PreviewProvider {
    static var previews: some View {
        MoviePostersRow(posters: [ImageData(aspect_ratio: 0.666_666_666_666_667,
                                             file_path: "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
                                             height: 720,
                                             width: 1280)],
                        selectedPoster: .constant(nil))
    }
}
#endif
