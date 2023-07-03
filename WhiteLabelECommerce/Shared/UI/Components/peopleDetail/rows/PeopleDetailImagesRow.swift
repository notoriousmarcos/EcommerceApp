//
//  PeopleDetailImagesRow.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Backend
import SwiftUI

struct PeopleDetailImagesRow: View {
    let images: [ImageData]
    @Binding var selectedPoster: ImageData?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Images")
                .titleStyle()
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 16) {
                    ForEach(images) { image in
                        PeopleImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: image.file_path, size: .cast))
                            .onTapGesture {
                                withAnimation {
                                    self.selectedPoster = image
                                }
                            }
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
struct PeopleDetailImagesRow_Previews: PreviewProvider {
    static var previews: some View {
        PeopleDetailImagesRow(images: sampleCasts.first!.images ?? [], selectedPoster: .constant(nil))
    }
}
#endif
