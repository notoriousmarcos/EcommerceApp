//
//  MovieReviews.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct MovieReviews: View {
    @EnvironmentObject var store: Store<AppState>

    let movie: Int

    var reviews: [Review] {
        return store.state.moviesState.reviews[movie] ?? []
    }

    var body: some View {
        List(reviews) {review in
            ReviewRow(review: review)
        }
        .navigationBarTitle(Text("Reviews"))
        .onAppear {
            self.store.dispatch(action: MoviesActions.FetchMovieReviews(movie: self.movie))
        }
    }
}
