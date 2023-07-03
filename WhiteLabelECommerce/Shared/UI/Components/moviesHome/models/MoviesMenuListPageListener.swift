//
//  MoviesHomeListPageListener.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

final class MoviesMenuListPageListener: MoviesPagesListener {
    var menu: MoviesMenu {
        didSet {
            currentPage = 1
        }
    }

    override func loadPage() {
        store.dispatch(action: MoviesActions.FetchMoviesMenuList(list: menu, page: currentPage))
    }

    init(menu: MoviesMenu, loadOnInit: Bool? = true) {
        self.menu = menu

        super.init()

        if loadOnInit == true {
            loadPage()
        }
    }
}
