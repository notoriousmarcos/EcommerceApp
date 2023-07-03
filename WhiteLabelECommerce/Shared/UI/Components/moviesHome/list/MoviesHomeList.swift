//
//  MoviesHomeList.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Combine
import SwiftUI

struct MoviesHomeList: ConnectedView {
    struct Props {
        let movies: [Int]
    }

    @Binding var menu: MoviesMenu

    let pageListener: MoviesMenuListPageListener

    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        Props(movies: state.moviesState.moviesList[menu] ?? [0, 0, 0, 0])
    }

    func body(props: Props) -> some View {
        MoviesList(movies: props.movies,
                   displaySearch: true,
                   pageListener: pageListener)
    }
}

#if DEBUG
struct MoviesHomeList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoviesHomeList(menu: .constant(.popular),
                           pageListener: MoviesMenuListPageListener(menu: .popular))
                .environmentObject(sampleStore)
        }
    }
}
#endif
