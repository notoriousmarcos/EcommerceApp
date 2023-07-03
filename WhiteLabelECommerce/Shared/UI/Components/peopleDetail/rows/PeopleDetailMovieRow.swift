//
//  PeopleDetailMovieRow.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Backend
import SwiftUI

struct PeopleDetailMovieRow: View {
    @EnvironmentObject var store: Store<AppState>

    let movieId: Int
    private var movie: Movie! {
        return store.state.moviesState.movies[movieId]
    }
    let role: String

    let onMovieContextMenu: () -> Void

    var body: some View {
        HStack {
            ZStack {
                MoviePosterImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: movie.poster_path,
                                                                                size: .small),
                                 posterSize: .small)
                ListImage(movieId: movieId)
            }.fixedSize()
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)
                Text(role)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }.contextMenu { MovieContextMenu(movieId: movieId, onAction: onMovieContextMenu) }
    }
}

#if DEBUG
struct PeopleDetailMovieRow_Previews: PreviewProvider {
    static var previews: some View {
        PeopleDetailMovieRow(movieId: sampleMovie.id, role: "Test", onMovieContextMenu: {
        }).environmentObject(sampleStore)
    }
}
#endif
