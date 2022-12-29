//
//  ListItemView.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 29/12/22.
//

import SwiftUI

struct ListItemView: View {
    let viewModel: ListItemsViewModelProtocol

    init(viewModel: ListItemsViewModelProtocol) {
        self.viewModel = viewModel
    }
    var body: some View {
        Text("Hello, World!")
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var fetchAllItems: ((Result<[Product], DomainError>) -> Void) -> Void = { completion in
        completion(.success(Mocks.products))
    }


    static var previews: some View {
        ListItemView(viewModel: ListItemsViewModel(fetchAllItems: fetchAllItems))
            .environment(\.sizeCategory, .extraSmall)

        ListItemView(viewModel: ListItemsViewModel(fetchAllItems: fetchAllItems))

        ListItemView(viewModel: ListItemsViewModel(fetchAllItems: fetchAllItems))
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
