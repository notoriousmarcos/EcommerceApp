import Combine
import SwiftUI

import AppState

public class RootViewModel: ObservableObject {
  @Published var isAuthorized = true

  private var subscriptions: Set<AnyCancellable> = []

  public init(appState: Store<AppState>) {
    appState.map(\.auth.isAuthorized)
      .removeDuplicates()
      .assign(to: \.isAuthorized, on: self)
      .store(in: &subscriptions)
  }

  deinit {
#if DEBUG
    // print("Deinit \(Self.self)")
#endif
  }
}
