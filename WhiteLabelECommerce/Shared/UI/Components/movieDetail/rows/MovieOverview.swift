//
//  MovieOverview.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct MovieOverview: View {
    let movie: Movie
    @State var isOverviewExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overview:")
                .titleStyle()
                .lineLimit(1)
            Text(movie.overview)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(self.isOverviewExpanded ? nil : 4)
                .onTapGesture {
                    withAnimation {
                        self.isOverviewExpanded.toggle()
                    }
                }
            Button(action: {
                withAnimation {
                    self.isOverviewExpanded.toggle()
                }
            }, label: {
                Text(self.isOverviewExpanded ? "Less" : "Read more")
                    .lineLimit(1)
                    .foregroundColor(.steam_blue)
            })
        }
    }
}

#if DEBUG
struct MovieOverview_Previews: PreviewProvider {
    static var previews: some View {
        MovieOverview(movie: sampleMovie)
    }
}
#endif
