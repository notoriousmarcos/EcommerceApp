//
//  MovieGridRow.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Backend
import SwiftUI
import UI

struct MovieGridRow: ConnectedView {
    struct Props {
        let movie: Movie
    }

    let movieId: Int

    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        Props(movie: state.moviesState.movies[movieId]!)
    }

    func body(props: Props) -> some View {
        MoviePosterImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: props.movie.poster_path,
                                                                        size: .medium),
                         posterSize: .medium)
    }
}
