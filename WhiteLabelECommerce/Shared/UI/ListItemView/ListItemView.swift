//
//  ListItemView.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 29/12/22.
//

import SwiftUI

struct ListItemView<ViewModel: ListItemsViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("List items")
                switch viewModel.state {
                    case .loaded(let items):
                        List(items, id: \.id) { item in
                            Text(item.title)
                        }
                    case .failed(let error):
                        VStack {
                            Text("Sorry, we get something wrong: \(error.localizedDescription)")
                            Button(action: viewModel.reload, label: { Text("Retry") })
                        }
                    case .idle:
                        Color.clear
                }
            }
        }
        .onAppear(perform: {
            viewModel.onLoad()
        })
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
