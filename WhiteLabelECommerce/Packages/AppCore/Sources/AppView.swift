import SwiftUI

import AppState

public struct AppView: View {
  private let appState: Store<AppState>

  public init(appState: Store<AppState>) {
    self.appState = appState
    CompositionRoot.setup(state: appState)
  }

  public var body: some View {
    CompositionRoot.rootView
  }
}
