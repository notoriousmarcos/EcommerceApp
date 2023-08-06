//
//  AppContainer.swift
//  
//
//  Created by Marcos Vinicius Brito on 06/08/23.
//

import SwiftUI

public struct AppContainer: EnvironmentKey {

  public let appState: Store<AppState>

  public init(appState: Store<AppState>) {
    self.appState = appState
  }

  public init(appState: AppState) {
    self.init(appState: Store<AppState>(appState))
  }

  public static var defaultValue: Self { Self.default }

  private static let `default` = Self(appState: AppState())
}

public extension EnvironmentValues {
  var injected: AppContainer {
    get { self[AppContainer.self] }
    set { self[AppContainer.self] = newValue }
  }
}

// MARK: - Injection in the view hierarchy

public extension View {

  func inject(_ appState: AppState) -> some View {
    let container = AppContainer(appState: .init(appState))
    return inject(container)
  }

  func inject(_ container: AppContainer) -> some View {
    return self
      .environment(\.injected, container)
  }
}
