import SwiftUI

import AppState
import RootFeature
import ShopCore

public struct AppView: View {
  let container: AppContainer
  let shopCore: ShopCore

  public init(container: AppContainer, shopCore: ShopCore = .init()) {
    self.container = container
    self.shopCore = shopCore
  }

  public var body: some View {
    rootView
      .inject(container)
  }

  var rootView: some View {
    RootView(
      viewModel: rootViewModel,
      welcomeViewProvider: welcomeProvider,
      tabBarViewProvider: { tabBarView }
    )
  }

  private var rootViewModel: RootViewModel {
    RootViewModel(container: container)
  }

  private func welcomeProvider() -> some View {
    AnyView(Text(""))
  }
}
