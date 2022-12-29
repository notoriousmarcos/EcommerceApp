//
//  ListItemsViewModel.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 29/12/22.
//

import Foundation
import Combine

class ListItemsViewModel {
    // MARK: - Public Properties
    @Published private(set) var state: ViewState<[Product], Error> = .idle

    // MARK: - Private Properties
    private let fetchAllItems: (ResultCompletionHandler<[Product], DomainError>) -> Void

    // MARK: - Init
    init(fetchAllItems: @escaping (ResultCompletionHandler<[Product], DomainError>) -> Void) {
        self.fetchAllItems = fetchAllItems
    }

    deinit {
        print("Deinit ListItemsViewModel")
    }

    // MARK: - Functions
    func onLoad() {
        fetchItems()
    }

    func reload() {
        fetchItems()
    }

    // MARK: - Private Functions
    private func fetchItems() {
        fetchAllItems { [weak self] result in
            switch result {
                case.success(let products):
                    self?.state = .loaded(products)
                case .failure(let error):
                    self?.state = .failed(error)
            }
        }
    }
}
