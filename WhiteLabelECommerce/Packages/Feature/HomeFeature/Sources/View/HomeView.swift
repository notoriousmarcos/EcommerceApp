//
//  HomeView.swift
//  
//
//  Created by Marcos Vinicius Brito on 01/08/23.
//

import AppState
import NotoriousComponentsKit
import SwiftUI

public struct HomeView: View {
  // MARK: - Properties
  @ObservedObject var viewModel: HomeViewViewModel

  public init(viewModel: HomeViewViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body
  public var body: some View {
    ZStack {
      // MARK: - Background
      Color.backgroundColor

      ScrollView(.vertical, showsIndicators: true) {
        VStack(spacing: 24) {
          HeaderView() //: HStack

          //        BrandView()
          //          .padding(.top, 16)

          HomeToolBarView(searchText: $viewModel.searchText)

          SectionAndContentView(
            section: Section(
              title: "Top products",
              actionTitle: "See All",
              action: {
                // TODO: - Action
              }
            )
          ) {
            viewModel.topProductsContentView()
          }
        } //: VStack
        .padding(.horizontal, 24)
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HomeView(
        viewModel: HomeViewViewModel(
          containter: AppContainer(appState: Store<AppState>(AppState())),
          topProductsContentView: {
            AnyView(Text("All Products"))
          }
        )
      )
      HomeView(
        viewModel: HomeViewViewModel(
          containter: AppContainer(appState: Store<AppState>(AppState())),
          topProductsContentView: {
            AnyView(Text("All Products"))
          }
        )
      )
      .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      HomeView(
        viewModel: HomeViewViewModel(
          containter: AppContainer(appState: Store<AppState>(AppState())),
          topProductsContentView: {
            AnyView(Text("All Products"))
          }
        )
      )
      .preferredColorScheme(.dark)
    }
  }
}
