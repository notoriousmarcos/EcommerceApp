import Combine
import SwiftUI

import AppState

public class WelcomeViewModel: ObservableObject {
  private let appState: Store<AppState>

  public init(appState: Store<AppState>) {
    self.appState = appState
  }

  // MARK: - Input

  // MARK: - Output

  deinit {
#if DEBUG
    // print("Deinit \(Self.self)")
#endif
  }
}

extension WelcomeViewModel {
  func signInAction() {
    appState[\.auth.isAuthorized] = true
  }
}